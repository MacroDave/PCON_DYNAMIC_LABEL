close @all
%path = @runpath
cd %path

'Import CPI Sub-group data
import cpi_sub_groups.xlsx range=Data colhead=3 namepos=custom colheadnames=("Description","Description","Name") na="#N/A" @id @date(series_id) @smpl @all

'Import CPI Weights (17th series)
importtbl(name=__weights) cpi_sub_groups.xlsx range="Weights!A1:B87" 

delete(noerr) series_id

%subs = "A2327061R	A2327106J	A2327151V	A2327196X	A2327241X	A3604358R	A2327286C	A2327376J	A2327466L	A2327511L	A2326926W	A2326971J	A2327016C	A2330931T	A2330976W	A2327646W	A2327691J	A2329491A	A2329536V	A2331741W	A2327781L	A2327736A	A2331786A	A2327556T	A2327601T	A2328951K	A2328906X	A2328861F	A2328996R	A2329581F	A2329716C	A2329761R	A2327916K	A2327961W	A2328006T	A2329851V	A2328051C	A2326431V	A2329941X	A2328096J	A2329986C	A2329896X	A2328141J	A2331921F	A2328186L	A3604433C	A3604383T	A2328276T	A2331021X	A2331066C	A2328321T	A2328366W	A2329221A	A2330121R	A2331606F	A2329266F	A2331696W	A2329176A	A2329086W	A2329041T	A2329131W	A2328591T	A2328726R	A2328636K	A2328771A	A2328681W	A2328816V	A2328501A	A2328546F	A2329311F	A3604443J	A2330211V	A3604393W	A2329356K	A2329401K	A2330346C	A2330391R	A2328456A	A2328411W	A2330436J	A2330481V	A2331471J	A2331516A	A2331561L	A3602878J	A2332776R"

'A3604448V Index Numbers ;  Deposit and loan facilities (direct charges) ;  Australia ;
'A2325846C Index Numbers ;  All groups CPI ;  Australia ;

'NAIRU (old version, LR value of 5)
smpl @all
series NAIRU = NA
NAIRU.fill 6.72238181030961	,6.70988102980215	,6.69937494041561	,6.68641665100023	,6.6775439924377	,6.68431814336472	,6.68174443636385	,6.65875085602084	,6.62592463423329	,6.57063380554851	,6.51984426659414	,6.46798420182313	,6.43626636860034	,6.40158202986591	,6.37176312657131	,6.34098554026971	,6.30824404953998	,6.26629182430866	,6.23111932785808	,6.21393937183072	,6.19694771769395	,6.18822743927574	,6.17600856587337	,6.16077421254714	,6.14752070548026	,6.12935028766648	,6.12012463058641	,6.11449094610298	,6.11433478034064	,6.11044782353	,6.11423382494063	,6.1177302145268	,6.10949077905978	,6.11375387329179	,6.1129808835402	,6.11141041889936	,6.1118707665627	,6.12309681635267	,6.14029020297332	,6.15042552629711	,6.15623658405177	,6.16118721572445	,6.17126462007527	,6.18052694676689	,6.18869008105864	,6.1945034301865	,6.19216444636045	,6.18866751283925	,6.17957815470014	,6.16363304374767	,6.14605056011088	,6.12937183615288	,6.11248638991509	,6.09716160366816	,6.08351060198607	,6.06702674569801	,6.04952154707309	,6.03882495004485	,6.02860808814505	,6.01461045388377	,6.00354230992669	,5.99233069575552	,5.97663399402403	,5.96336175939696	,5.94893059202134	,5.9313635957032	,5.91341337691274	,5.89693995415114	,5.87851772485109	,5.86182275052701	,5.84676488139146	,5.83492501208856	,5.82197249655524	,5.80535377797632	,5.79137763426479	,5.78031612227306	,5.76686918325838	,5.7579517887704	,5.74860528828936	,5.73826999801014	,5.73205712543518	,5.72338257645599	,5.7086050332644	,5.69158075629944	,5.67437170111934	,5.65782797895792	,5.64259952660526	,5.62765116888198	,5.61261207789183	,5.59667807063267	,5.58546345174848	,5.5741388994825	,5.55938736811791	,5.54655115176982	,5.53324503160623	,5.51933442766387	,5.50725069329811	,5.49026332776396	,5.47398980142398	,5.46012867323513	,5.44876060752447	,5.43379019598104	,5.4195805353749	,5.39973558274904	,5.38299415422415	,5.36987756990434	,5.34952018533585	,5.32725253731241	,5.30077787173399	,5.27687397928018	,5.25703693172084	,5.23865188427869	,5.21768134372515	,5.20551456015501	,5.19784328930492	,5.19384396686463	,5.19311782401937	,5.18682141658869	,5.18228792173824	,5.17609736356779	,5.16618936140412	,5.15133476021495	,5.13419815817497	,5.11277142934654	,5.09144073014602	,5.07296361363579	,5.05599699944923	,5.03347146470969	,5.01556366589955	,5.00550273853837	,4.99546661109336	,4.98544359919907	,4.97743102174908	,4.97160922755049	,4.96280169222465	,4.95520163337574	,4.94729902882334	,4.93961334107929	,4.93174658780911	,4.92924381561076	,4.92571265739477	,4.92350005128034	,4.92122195612202	,4.92124389597431	,4.92313245647788	,4.9259711848614	,4.93536029296112	,4.94349911367815	,4.95102032919127	,4.9586822790451	,4.96559199905063	,4.96951521725967	,4.97949643987331	,4.98783386341268	,4.993795911379	,4.99941019547117	,5.00272352507249	,5.00359086305176	,5.00354259478515	,5.00354259478515	,5.00354259478515	,5.00354259478515	,5.00354259478515	,5.00354259478515	,5.00354259478515	,5.00354259478515	,5.00354259478515

smpl @all

smpl @all

'************************************Year-on-Year************************************'
'GST
	smpl @all
	series d_GST_YOY = 0
	smpl 1/09/2000 1/06/2001
	d_GST_YOY = 1

	smpl @all
	series d_GST_QOQ = 0
	smpl 1/09/2000 1/09/2000
	d_GST_QOQ = 1

'COVID
	smpl @all
	series d_COVID = 0
	smpl 2020q2 2020q2
	d_COVID = 1

'Supply
	smpl @all
	series d_SUPPLY = 0
	smpl 2021q2 2021q2
	d_SUPPLY = 1

'************************************Year-on-Year************************************'

setmaxerrs 100

table __results_yoy
__results_yoy(1,1) = "Component"
__results_yoy(1,2) = "Labour"
__results_yoy(1,3) = "ER"
__results_yoy(1,4) = "Persistence"
__results_yoy(1,5) = "Other"

%labour="series dl4Labour = "
%ER="series dl4ER = "
%Persist="series dl4Persist = "
%Other="series dl4Other = "

!i=1

for %var {%subs}

	smpl @all
	{%var}.x12
	delete {%var}
	rename {%var}_sa {%var}

	!first = @ifirst({%var})

	!i=!i+1
	__results_yoy(!i,1) = %var

	smpl 1993q1 2019q4 '
	if !first < 72 then
		EQUATION _{%VAR}_yoy.LS LOG({%var}/{%var}(-4))*100 = C(1) + c(2)*pi_e(-1) + c(3)*(LUR(-1) - NAIRU(-1))/LUR(-1) + 100*1/3*C(4)*(LOG(twi(-1)/LOG(twi(-5))) + LOG(twi(-2)/LOG(twi(-6))) + LOG(twi(-3)/LOG(twi(-7))) ) + 100*1/3*C(5)*(LOG({%VAR}(-1)/LOG({%VAR}(-5))) + LOG({%VAR}(-2)/LOG({%VAR}(-6))) + LOG({%VAR}(-3)/LOG({%VAR}(-7))) ) + c(111)*d_GST_YOY
	else
		EQUATION _{%VAR}_yoy.LS LOG({%var}/{%var}(-4))*100 = C(1) + c(2)*pi_e(-1) + c(3)*(LUR(-1) - NAIRU(-1))/LUR(-1) + 100*1/3*C(4)*(LOG(twi(-1)/LOG(twi(-5))) + LOG(twi(-2)/LOG(twi(-6))) + LOG(twi(-3)/LOG(twi(-7))) ) + 100*1/3*C(5)*(LOG({%VAR}(-1)/LOG({%VAR}(-5))) + LOG({%VAR}(-2)/LOG({%VAR}(-6))) + LOG({%VAR}(-3)/LOG({%VAR}(-7))) )
	endif

	if _{%var}_yoy.@pval(3) < 0.1 and c(3)<0 then
		__results_yoy(!i,2) = "1"
		%w=@str(__weights(!i,2)/100)
		%labour = %labour + " + " + %var + "*" + %w
	else
	if _{%var}_yoy.@pval(4) < 0.1 and c(4)<0 then
		__results_yoy(!i,3) = "1"		
		%w=@str(__weights(!i,2)/100)
		%ER = %ER + " + " + %var + "*" + %w 
	else
	if _{%var}_yoy.@pval(5) < 0.1 and C(5)>0 then
		__results_yoy(!i,4) = "1"
		%w=@str(__weights(!i,2)/100)
		%persist = %persist + " + " + %var + "*" + %w
	else
		__results_yoy(!i,5) = "1"
		%w=@str(__weights(!i,2)/100)
		%other = %other + " + " + %var + "*" + %w
	endif
	endif
	endif

	smpl @all
	series dl4{%var} = log({%var}/{%var}(-4))*100
	
next

smpl @all
{%labour}
{%ER}
{%persist}
{%other}

'************************************Quarter-on-Quarter************************************'

table __results_qoq
__results_qoq(1,1) = "Component"
__results_qoq(1,2) = "Labour"
__results_qoq(1,3) = "ER"
__results_qoq(1,4) = "Persistence"
__results_qoq(1,5) = "Other"

%labour="series dlLabour = "
%ER="series dlER = "
%Persist="series dlPersist = "
%Other="series dlOther = "

!i=1
for %var {%subs}

	!i=!i+1
	__results_qoq(!i,1) = %var

	smpl @all
	!first = @ifirst({%var})

	smpl 1993q1 2019q4	

	if !first<75 then
		EQUATION _{%VAR}_qoq.LS LOG({%var}/{%var}(-1))*100 = C(1) + c(2)*pi_e(-1) + c(3)*(LUR(-1) - NAIRU(-1))/LUR(-1) + 100*1/3*C(4)*(LOG(twi(-1)/LOG(twi(-2))) + LOG(twi(-2)/LOG(twi(-3))) + LOG(twi(-3)/LOG(twi(-4))) ) + 100*1/3*C(5)*(LOG({%VAR}(-1)/LOG({%VAR}(-2))) + LOG({%VAR}(-2)/LOG({%VAR}(-3))) + LOG({%VAR}(-3)/LOG({%VAR}(-4))) ) + c(111)*d_GST_QOQ
	else
		EQUATION _{%VAR}_qoq.LS LOG({%var}/{%var}(-1))*100 = C(1) + c(2)*pi_e(-1) + c(3)*(LUR(-1) - NAIRU(-1))/LUR(-1) + 100*1/3*C(4)*(LOG(twi(-1)/LOG(twi(-2))) + LOG(twi(-2)/LOG(twi(-3))) + LOG(twi(-3)/LOG(twi(-4))) ) + 100*1/3*C(5)*(LOG({%VAR}(-1)/LOG({%VAR}(-2))) + LOG({%VAR}(-2)/LOG({%VAR}(-3))) + LOG({%VAR}(-3)/LOG({%VAR}(-4))) ) 
	endif

	if _{%var}_qoq.@pval(3) < 0.1 and c(3)<0 then
		__results_qoq(!i,2) = "1"
		%w=@str(__weights(!i,2)/100)
		%labour = %labour + " + " + %var + "*" + %w
	else
	if _{%var}_qoq.@pval(4) < 0.1 and c(4)<0 then
		__results_qoq(!i,3) = "1"		
		%w=@str(__weights(!i,2)/100)
		%er = %er + " + " + %var + "*" + %w
	else
	if _{%var}_qoq.@pval(5) < 0.1 and C(5)>0 then
		__results_qoq(!i,4) = "1"
		%w=@str(__weights(!i,2)/100)
		%persist = %persist + " + " + %var + "*" + %w
	else
		__results_qoq(!i,5) = "1"
		%w=@str(__weights(!i,2)/100)
		%other = %other + " + " + %var + "*" + %w
	endif
	endif
	endif

	smpl @all
	series dl{%var} = log({%var}/{%var}(-1))*100
	
next

smpl @all
{%labour}
{%ER}
{%persist}
{%other}


'************************************PCA************************************'

group cpi_subs dl4*
smpl 1/03/1993 @last
cpi_subs.makepcomp(scale=normscore) pc1 pc2 pc3 pc4

smpl @all

'************************************Plots************************************'
smpl 2005q1 2022q1
graph g_prices.line @PCY(dl4labour) ptmy
g_prices.name(1) "YoY Labour Market Sensitive Inflation"
g_prices.name(2) "YoY Trimmed Mean Inflaton"
show g_prices


