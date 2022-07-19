' -------------------------------------------------------------------------------------
' -------------------------------------------------------------------------------------
' Narrative PCON Decomposition
' Programmer: David Stephan
' Last Updated: July, 2022
' email: david.stephan@gmail.com
' -------------------------------------------------------------------------------------

%path=@runpath
cd %path
close @all
logmode l
!count=150 '150 was until Mar-22. Change for subsquent quarters
!lags=0 '(=1 include lags of variables =0 no lags)
!growth=0 '(=1 growth regression or =0 log level regressions)
!trend=1 '(=1 include a linear trend =0 not linear trend)
!qdums=1 '(=1 includes quarterly dummies =0 no dummies)

'********************************************************************************
'LOAD DATA FROM NATACCS
'********************************************************************************

wfcreate(wf=pcon_narrative,page=pcon_narrative) q 1959q3 2022q1
import "\\romulus\ECD_PRO$\DATA\NATACCS\5206008_Household_Final_Consumption_Expenditure.xlsx" range=Data1 colhead=10 namepos=last na="#N/A" @id @date(series_id) @destid @date @smpl @all

%qvars = "A2303246R A2303248V	A2303250F	A2303252K	A2303254R	A2303256V	A2303258X	A2303260K	A2303262R	A2303264V	A2303266X	A2303268C	A2303270R	A2303272V	A2303274X	A2303276C	A2303278J "

%vvars= "A2302219R	A2302220X	A2302221A	A2302222C	A2302223F	A2302224J	A2302225K	A2302226L	A2302227R	A2302228T	A2302229V	A2302230C	A2302231F	A2302232J	A2302233K	A2302234L	A2302235R "

%varnames="Food	Cigs	Alcoh	Cloth	Rent	Elec	Furnsh	Health	Pveh	Oveh	Trans	Comms	Recr	Educ	Hotl	FinO	Other"

group g_all *
string s_all=g_all.@members
s_all=@wdrop(s_all,%qvars)
s_all=@wdrop(s_all,%vvars)
s_all=@wdrop(s_all, "A2303280V A2302236T")
delete {s_all} s_all g_all

'************************************************************************************************
'Data Manipulations
'************************************************************************************************
smpl @all

svector svnames=@wsplit(%varnames)

'Rename vars
!i=0
for %var {%qvars}
	!i=!i+1
	%temp=svnames(!i)
	rename {%var} q_{%temp}
next

%total="" 

!i=0
for %var {%vvars}
	!i=!i+1
	%temp=svnames(!i)
	rename {%var} v_{%temp}
	%total = %total + "+v_"+%temp
next

'Total Nominal Household Consumption
series v_total = {%total}

for %var {%varnames}
	series p_{%var} = v_{%var}/q_{%var}
	series dp_{%var} = @pc(p_{%var})
	series w_{%var} = v_{%var}/v_total
next

'Total PCON Deflator
smpl @all
series pcon = A2302236T/A2303280V

'Quarterly Dummies
Series dumq2=@quarter=2
Series dumq3=@quarter=3
Series dumq4=@quarter=4

'************************************************************************************************
'ROLLING REGRESSIONS
'************************************************************************************************

'Pre-COVID sample period for resid testing
	sample ssest 1959q3 2019q4
	SMPL 1974q3+39 2019Q4
	!OBS=@OBSSMPL

if !growth = 1 then
	%depvar="dlog"
else
	%depvar="log"
endif

if !trend = 1 then
	%trend=" @trend"
endif

if !qdums=1 then
	%qdums=" dumq2 dumq3 dumq4"
endif

for %var {%varnames}
	
	smpl @all
	series res_p_{%var} = NA
	series res_q_{%var} = NA
	series dm_{%var} = NA
	series sp_{%var} = NA
	series am_{%var} = NA

	if !lags=1 then
		%lags = %depvar+"(p_"+%var+"(-1)) "+%depvar+"(p_"+%var+"(-2)) "+%depvar+"(p_"+%var+"(-3)) "+%depvar+"(p_"+%var+"(-4)) "+%depvar+"(q_"+%var+"(-1)) "+%depvar+"(q_"+%var+"(-2)) "+%depvar+"(q_"+%var+"(-3)) "+%depvar+"(q_"+%var+"(-4))"
	endif

	for !i=0 to !count

		smpl 1974q3+!i 1974q3+!i+39
		equation _p_{%var}.ls {%depvar}(p_{%var}) c {%lags} {%trend} {%qdums}
		smpl 1974q3+!i+40 1974q3+!i+40
		_p_{%var}.fit(d) p_{%var}f
		res_p_{%var} = {%depvar}(p_{%var})-p_{%var}f
		
		smpl 1974q3+!i 1974q3+!i+39
		equation _q_{%var}.ls {%depvar}(q_{%var}) c  {%lags} {%trend} {%qdums}
		smpl 1974q3+!i+40 1974q3+!i+40
		_q_{%var}.fit(d) q_{%var}f
		res_q_{%var} = {%depvar}(q_{%var})-q_{%var}f

	next

	smpl 1984q3 @last

	'Supply Coding
	sp_{%var} = @recode( (res_p_{%var}>0 and res_q_{%var}<0) or (res_p_{%var}<0 and res_q_{%var}>0),1,sp_{%var})
	sp_{%var} = @recode(res_p_{%var}>@quantile(res_p_{%var},0.4) and res_p_{%var}<=@quantile(res_p_{%var},0.6),0,sp_{%var})
	sp_{%var} = @recode(res_q_{%var}>@quantile(res_q_{%var},0.4) and res_q_{%var}<=@quantile(res_q_{%var},0.6),0,sp_{%var})
	sp_{%var} = @recode(sp_{%var}=NA,0,sp_{%var})

	'Demand Coding
	dm_{%var} = @recode( (res_p_{%var}>0 and res_q_{%var}>0) or (res_p_{%var}<0 and res_q_{%var}<0),1,dm_{%var})
	dm_{%var} = @recode(res_p_{%var}>@quantile(res_p_{%var},0.4) and res_p_{%var}<=@quantile(res_p_{%var},0.6),0,dm_{%var})
	dm_{%var} = @recode(res_q_{%var}>@quantile(res_q_{%var},0.4) and res_q_{%var}<=@quantile(res_q_{%var},0.6),0,dm_{%var})
	dm_{%var} = @recode(dm_{%var}=NA,0,dm_{%var})

	'Ambiguous Coding (=0)
	am_{%var} = @recode(dm_{%var}=0 and sp_{%var}=0,1,0)

next

group dms dm_*
stom(dms,dmm)

group sps sp_*
stom(sps,spm)

group ams am_*
stom(ams,amm)

group wms w_*
stom(wms,wmm)

group dps dp_*
stom(dps,dpm)

matrix dmmw = @emult(wmm,dmm)
matrix spmw = @emult(wmm,spm)
matrix ammw = @emult(wmm,amm)

vector(@rows(dmmw)) v_demand
vector(@rows(spmw)) v_supply
vector(@rows(ammw)) v_ambig

for !i=1 to @rows(wmm)
	!tempval=@rowextract(dmmw,!i)*@transpose(@rowextract(dpm,!i))
	v_demand(!i,1) = !tempval

	!tempval=@rowextract(spmw,!i)*@transpose(@rowextract(dpm,!i))
	v_supply(!i,1) = !tempval

	!tempval=@rowextract(ammw,!i)*@transpose(@rowextract(dpm,!i))
	v_ambig(!i,1) = !tempval

next

mtos(v_demand,demand)
mtos(v_supply,supply)
mtos(v_ambig,ambig) 

smpl 2010q1 @last
group g_chart @movsum(demand,4) @movsum(ambig,4) @movsum(supply,4) @pcy(pcon)
delete(noerr) gr_chart
freeze(gr_chart) g_chart.mixed(llast) stackedbar(1,2,3) line(4)
gr_chart.name(1) Demand
gr_chart.name(2) Ambiguous
gr_chart.name(3) Supply
gr_chart.name(4) 
gr_chart.setelem(1) fillcolor(@rgb(0,44,71))
gr_chart.setelem(2) fillcolor(@rgb(230,30,38))
gr_chart.setelem(3) fillcolor(@rgb(58,111,175))
gr_chart.setelem(1) linecolor(@rgb(0,0,0))
gr_chart.legend(2,0.1)

show gr_chart

