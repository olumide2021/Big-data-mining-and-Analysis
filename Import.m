%%=========================================================================%
%IMPORT DATA
clear 
clc

%=========================================================================%
%Import data for models that require up to 10 years of the accident data
%=========================================================================%

%% Import the highway-rail grade crossing inventory file
[~, ~, FloridaCrossings] = xlsread('Florida_Crossings.xls','CI_Crossings','A2:FY9578');
FloridaCrossings(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaCrossings)) = {''};

[~, ~, Heading] = xlsread('Florida_Crossings.xls','CI_Crossings','A1:FY1');
Heading(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),Heading)) = {''};

%=========================================================================%
%% Import the Florida Accident Data File for 2017
[~, ~, FloridaAccidentData] = xlsread('Florida Accident Data.xlsx','2017','A2:CY107');
FloridaAccidentData(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentData)) = {''};

[~, ~, Headingacc] = xlsread('Florida Accident Data.xlsx','2017','A1:CY1');
Headingacc(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),Headingacc)) = {''};


%% Import the Florida Accident Data File for 2016
[~, ~, FloridaAccidentDataS1] = xlsread('Florida Accident Data.xlsx','2016','A2:CY86');
FloridaAccidentDataS1(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS1)) = {''};

%% Import the Florida Accident Data File for 2015
[~, ~, FloridaAccidentDataS2] = xlsread('Florida Accident Data.xlsx','2015','A2:CY81');
FloridaAccidentDataS2(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS2)) = {''};

%% Import the Florida Accident Data File for 2014
[~, ~, FloridaAccidentDataS3] = xlsread('Florida Accident Data.xlsx','2014','A2:CY88');
FloridaAccidentDataS3(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS3)) = {''};

%% Import the Florida Accident Data File for 2013
[~, ~, FloridaAccidentDataS4] = xlsread('Florida Accident Data.xlsx','2013','A2:CY66');
FloridaAccidentDataS4(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS4)) = {''};

%% Import the Florida Accident Data File for 2012
[~, ~, FloridaAccidentDataS5] = xlsread('Florida Accident Data.xlsx','2012','A2:CY60');
FloridaAccidentDataS5(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS5)) = {''};

%% Import the Florida Accident Data File for 2011
[~, ~, FloridaAccidentDataS6] = xlsread('Florida Accident Data.xlsx','2011','A2:CY53');
FloridaAccidentDataS6(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS6)) = {''};

%% Import the Florida Accident Data File for 2010
[~, ~, FloridaAccidentDataS7] = xlsread('Florida Accident Data.xlsx','2010','A2:CY68');
FloridaAccidentDataS7(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS7)) = {''};

%% Import the Florida Accident Data File for 2009
[~, ~, FloridaAccidentDataS8] = xlsread('Florida Accident Data.xlsx','2009','A2:CY52');
FloridaAccidentDataS8(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS8)) = {''};

%% Import the Florida Accident Data File for 2008
[~, ~, FloridaAccidentDataS9] = xlsread('Florida Accident Data.xlsx','2008','A2:CY77');
FloridaAccidentDataS9(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS9)) = {''};

%% Import the Florida Accident Data File for 2007
[~, ~, FloridaAccidentDataS10] = xlsread('Florida Accident Data.xlsx','2007','A2:CY91');
FloridaAccidentDataS10(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),FloridaAccidentDataS10)) = {''};

%% Combine all the accident data files into a single file
Accident_Data_Current = (FloridaAccidentData);
Accident_Data_1Y = (FloridaAccidentDataS1);
Accident_Data_2Y = [FloridaAccidentDataS1; FloridaAccidentDataS2];
Accident_Data_3Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3];
Accident_Data_4Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4];
Accident_Data_5Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5];
Accident_Data_6Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5; FloridaAccidentDataS6];
Accident_Data_7Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5; FloridaAccidentDataS6; FloridaAccidentDataS7];
Accident_Data_8Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5; FloridaAccidentDataS6; FloridaAccidentDataS7; FloridaAccidentDataS8];
Accident_Data_9Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5; FloridaAccidentDataS6; FloridaAccidentDataS7; FloridaAccidentDataS8; FloridaAccidentDataS9];
Accident_Data_10Y = [FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5; FloridaAccidentDataS6; FloridaAccidentDataS7; FloridaAccidentDataS8; FloridaAccidentDataS9; FloridaAccidentDataS10];
Accident_Data_all = [FloridaAccidentData; FloridaAccidentDataS1; FloridaAccidentDataS2; FloridaAccidentDataS3; FloridaAccidentDataS4; FloridaAccidentDataS5; FloridaAccidentDataS6; FloridaAccidentDataS7; FloridaAccidentDataS8; FloridaAccidentDataS9; FloridaAccidentDataS10];
Accident_Data_USDOT = Accident_Data_5Y;

%% Create a table with the accident data for all years
Florida_Accidentall = cell2table(Accident_Data_all, 'VariableNames', Headingacc(1,:));

%% Data required from FRA Accident Database (for the State of Florida)
Florida_Accident = Florida_Accidentall(:,{'GXID'});

%% Create a table with crossings inventory data
FloridaCrossingsdata = cell2table(FloridaCrossings, 'VariableNames',Heading(1,:));

%% Data required from Crossing Inventory Database
Crossing_Inventory = FloridaCrossingsdata(:,{'CrossingID','WdCode', 'Aadt', 'DayThru', 'NghtThru', 'TotalSwt',...
    'MaxTtSpd', 'MainTrk', 'OthrTrk', 'HwyClassCD', 'HwyPved', 'TraficLn','HwyClassrdtpID', 'AwdIDate','PosXing'});

%Merge both files based on the crossingID
DataFileJoin = join(Florida_Accident,Crossing_Inventory,'LeftKeys','GXID','RightKeys','CrossingID');

%% Accident History at highway-rail grade crossings

% Find the number of accidents at each highway-rail grade crossing in year for validation (2017)
a = unique(Accident_Data_Current(:,16),'stable');
b = cellfun(@(x) sum(ismember(Accident_Data_Current(:,16),x)),a,'un',0);
AH_curr = [a b];

CrossingID_curr=a;
Acchist_curr=cell2mat(b);
Headinghist_curr = {'GXID', 'Acchist_current'};
Acchist_curr = table (CrossingID_curr, Acchist_curr, 'VariableNames',Headinghist_curr);

% Find the number of accidents at each highway-rail grade crossing in year one (2016)
a1 = unique(Accident_Data_1Y(:,16),'stable');
b1 = cellfun(@(x) sum(ismember(Accident_Data_1Y(:,16),x)),a1,'un',0);
AH_1 = [a1 b1];

CrossingID1=a1;
Acchist1=cell2mat(b1);
Headinghist1 = {'GXID', 'Acchist1'};
Acchist1 = table (CrossingID1, Acchist1, 'VariableNames',Headinghist1);

% Find the number of accidents at each highway-rail grade crossing the past two years (2016-2015)
a2 = unique(Accident_Data_2Y(:,16),'stable');
b2 = cellfun(@(x) sum(ismember(Accident_Data_2Y(:,16),x)),a2,'un',0);
AH_2 = [a2 b2];

CrossingID2=a2;
Acchist2=cell2mat(b2);
Headinghist2 = {'GXID', 'Acchist2'};
Acchist2 = table (CrossingID2, Acchist2, 'VariableNames',Headinghist2);

% Find the number of accidents at each highway-rail grade crossing the past three years (2016-2014)
a3 = unique(Accident_Data_3Y(:,16),'stable');
b3 = cellfun(@(x) sum(ismember(Accident_Data_3Y(:,16),x)),a3,'un',0);
AH_3 = [a3 b3];

CrossingID3=a3;
Acchist3=cell2mat(b3);
Headinghist3 = {'GXID', 'Acchist3'};
Acchist3 = table (CrossingID3, Acchist3, 'VariableNames',Headinghist3);

% Find the number of accidents at each highway-rail grade crossing the past four years (2016-2013)
a4 = unique(Accident_Data_4Y(:,16),'stable');
b4 = cellfun(@(x) sum(ismember(Accident_Data_4Y(:,16),x)),a4,'un',0);
AH_4 = [a4 b4];

CrossingID4=a4;
Acchist4=cell2mat(b4);
Headinghist4 = {'GXID', 'Acchist4'};
Acchist4 = table (CrossingID4, Acchist4, 'VariableNames',Headinghist4);

% Find the number of accidents at each highway-rail grade crossing the past five years (2016-2012)
a5 = unique(Accident_Data_5Y(:,16),'stable');
b5 = cellfun(@(x) sum(ismember(Accident_Data_5Y(:,16),x)),a5,'un',0);
AH_5 = [a5 b5];

CrossingID5=a5;
Acchist5=cell2mat(b5);
Headinghist5 = {'GXID', 'Acchist5'};
Acchist5 = table (CrossingID5, Acchist5, 'VariableNames',Headinghist5);

% Find the number of accidents at each highway-rail grade crossing the past six years (2016-2011)
a6 = unique(Accident_Data_6Y(:,16),'stable');
b6 = cellfun(@(x) sum(ismember(Accident_Data_6Y(:,16),x)),a6,'un',0);
AH_6 = [a6 b6];

CrossingID6=a6;
Acchist6=cell2mat(b6);
Headinghist6 = {'GXID', 'Acchist6'};
Acchist6 = table (CrossingID6, Acchist6, 'VariableNames',Headinghist6);

% Find the number of accidents at each highway-rail grade crossing the past seven years (2016-2010)
a7 = unique(Accident_Data_7Y(:,16),'stable');
b7 = cellfun(@(x) sum(ismember(Accident_Data_7Y(:,16),x)),a7,'un',0);
AH_7 = [a7 b7];

CrossingID7=a7;
Acchist7=cell2mat(b7);
Headinghist7 = {'GXID', 'Acchist7'};
Acchist7 = table (CrossingID7, Acchist7, 'VariableNames',Headinghist7);

% Find the number of accidents at each highway-rail grade crossing the past eight years (2016-2009)
a8 = unique(Accident_Data_8Y(:,16),'stable');
b8 = cellfun(@(x) sum(ismember(Accident_Data_8Y(:,16),x)),a8,'un',0);
AH_8 = [a8 b8];

CrossingID8=a8;
Acchist8=cell2mat(b8);
Headinghist8 = {'GXID', 'Acchist8'};
Acchist8 = table (CrossingID8, Acchist8, 'VariableNames',Headinghist8);

% Find the number of accidents at each highway-rail grade crossing the past nine years (2016-2008)
a9 = unique(Accident_Data_9Y(:,16),'stable');
b9 = cellfun(@(x) sum(ismember(Accident_Data_9Y(:,16),x)),a9,'un',0);
AH_9 = [a9 b9];

CrossingID9=a9;
Acchist9=cell2mat(b9);
Headinghist9 = {'GXID', 'Acchist9'};
Acchist9 = table (CrossingID9, Acchist9, 'VariableNames',Headinghist9);

% Find the number of accidents at each highway-rail grade crossing the past ten years (2016-2007)
a10 = unique(Accident_Data_10Y(:,16),'stable');
b10 = cellfun(@(x) sum(ismember(Accident_Data_10Y(:,16),x)),a10,'un',0);
AH_10 = [a10 b10];

CrossingID10=a10;
Acchist10=cell2mat(b10);
Headinghist10 = {'GXID', 'Acchist10'};
Acchist10 = table (CrossingID10, Acchist10, 'VariableNames',Headinghist10);

% Find the number of accidents at each highway-rail grade crossing between 2007 and 2017
a_all = unique(Accident_Data_all(:,16),'stable');
b_all = cellfun(@(x) sum(ismember(Accident_Data_all(:,16),x)),a_all,'un',0);
AH_all = [a_all b_all];

CrossingID_all=a_all;
AcchistAll=cell2mat(b_all);
Headinghist_all = {'GXID', 'Acchist_all'};
AcchistAll  = table (CrossingID_all, AcchistAll , 'VariableNames',Headinghist_all);

% Find the number of accidents at each highway-rail grade crossing in the past 5 years (2017-2013) (FOR USDOT MODEL)
aUSDOT = unique(Accident_Data_USDOT(:,16),'stable');
bUSDOT = cellfun(@(x) sum(ismember(Accident_Data_USDOT(:,16),x)),aUSDOT,'un',0);
AH_USDOT = [aUSDOT bUSDOT];

CrossingID_USDOT=aUSDOT;
Acchist_USDOT=cell2mat(bUSDOT);
Headinghist_USDOT = {'GXID', 'Acchist_2016_2012'};
Acchist_USDOT = table (CrossingID_USDOT, Acchist_USDOT, 'VariableNames',Headinghist_USDOT);


%Merge both files based on the crossingID to include the accident history
DataFileMerge = join(DataFileJoin,AcchistAll,'LeftKeys','GXID','RightKeys','GXID');

%Create the Datafile with unique crossings number of accidents between
%2007-2016 and 2017 accident data
[~,idu] = unique(DataFileMerge(:,1));
DataFile10 = DataFileMerge(idu,:);

%Create the Datafile with unique crossings number of accidents for 10 years
DataFile105101 = outerjoin(Acchist10,DataFile10,'MergeKeys',true);

%Create the Datafile with number of accidents for 9 years
DataFile1059 = outerjoin(Acchist9,DataFile105101,'MergeKeys',true);

%Create the Datafile with number of accidents for 8 years
DataFile1058 = outerjoin(Acchist8,DataFile1059,'MergeKeys',true);

%Create the Datafile with number of accidents for 7 years
DataFile1057 = outerjoin(Acchist7,DataFile1058,'MergeKeys',true);

%Create the Datafile with number of accidents for 6 years
DataFile1056 = outerjoin(Acchist6,DataFile1057,'MergeKeys',true);

%Create the Datafile with number of accidents for 5 years
DataFile105 = outerjoin(Acchist5,DataFile1056,'MergeKeys',true);

%Create the Datafile with number of accidents for 4 years
DataFile1054 = outerjoin(Acchist4,DataFile105,'MergeKeys',true);

%Create the Datafile with number of accidents for 3 years
DataFile1053 = outerjoin(Acchist3,DataFile1054,'MergeKeys',true);

%Create the Datafile with number of accidents for 2 year
DataFile1052 = outerjoin(Acchist2,DataFile1053,'MergeKeys',true);

%Create the Datafile with number of accidents for 1 year
DataFile1051 = outerjoin(Acchist1,DataFile1052,'MergeKeys',true);

%Create the Datafile with number of accidents for 5 years (2017-2013) for USDOT Model
DataFileUSDOT1051 = outerjoin(Acchist_USDOT,DataFile1051,'MergeKeys',true);

%Create the Datafile with number of accidents in the year used for validation (2017)
DataFile10510 = outerjoin(Acchist_curr,DataFileUSDOT1051,'MergeKeys',true);

DataFile = [DataFile10510(:,1) DataFile10510(:,14:26) DataFile10510(:,4:13) DataFile10510(:,28) DataFile10510(:,2) DataFile10510(:,3) DataFile10510(:,27)];

%=========================================================================%
% Crossing ID from Raw Datafile
%=========================================================================%
CrossingIDraw = table2cell(DataFile(:,1));

%=========================================================================%
% Raw Data for Protection Type
%=========================================================================%
Protectionraw = table2cell(DataFile(:,2));

% If no protection is reported at a highway-rail-grade crossing assume a 
% value of '1' from the WdCode which denotes 'No signs or signal'
for i = 1:size(Protectionraw)
   if strcmp(Protectionraw{i,1},'')
       Protectionraw{i,1} = 1;
   end
end

%=========================================================================%
% Raw Data for Average Annual Daily Traffic
%=========================================================================%
AADTraw = table2array(DataFile(:,3));

for i = 1:size(AADTraw)
   if strcmp(AADTraw{i,1},'')
       AADTraw{i,1} = NaN;
   end
end
 
Vraw = cell2mat(AADTraw);

%=========================================================================%
% Raw Data for Trains per day
%=========================================================================%
Trainsperdayraw = table2array(DataFile(:,4:6));
Traw = cell2mat(Trainsperdayraw(:,1)) + cell2mat(Trainsperdayraw(:,2)) + cell2mat(Trainsperdayraw(:,3));

%=========================================================================%
% Raw Data for Maximum Timetable Speed
%=========================================================================%
mtspeedraw = table2array(DataFile(:,7));
msraw = cell2mat (mtspeedraw);

%=========================================================================%
% Raw Data for Number of Main and Other Tracks
%=========================================================================%
Nofmandotrksraw = table2array(DataFile(:,8:9));
mo1 = cell2mat(Nofmandotrksraw(:,1));
mo2 = Nofmandotrksraw(:,2);

for i = 1:size(mo2)
   if strcmp(mo2{i,1},'NULL')
       mo2{i,1} = 0;
   end
end
 
mo2 = cell2mat(mo2);
Craw = mo1 + mo2;

%=========================================================================%
% Raw Data for Number of Main Tracks
%=========================================================================%
Maintracksraw = table2array(DataFile(:,8));
MainTrkraw = cell2mat(Maintracksraw);

%=========================================================================%
% Raw Data for Classification of Road at Crossing
%=========================================================================%
HwyClassraw = table2array(DataFile(:,10));

for i = 1:size(HwyClassraw)
   if strcmp(HwyClassraw{i,1},'')
       HwyClassraw{i,1} = NaN;
   end
end

HwyClassCDraw = cell2mat(HwyClassraw);

%=========================================================================%
% Raw Data for Number of Through Trains per Day during Daylight
%=========================================================================%
daythrutrainsraw = table2array(DataFile(:,4));
draw = cell2mat(daythrutrainsraw);

%=========================================================================%
% Raw Data for Highway Paved 
%=========================================================================%
hpavedraw = table2array(DataFile(:,11));

for i = 1:size(hpavedraw)
   if strcmp(hpavedraw{i,1},'')
       hpavedraw{i,1} = NaN;
   end
end

hpraw = cell2mat(hpavedraw);
hpraw(isnan(hpraw))=0;

%=========================================================================%
% Raw Data for Highway Type
%=========================================================================%
hwaytyperaw = table2array(DataFile(:,13));

for i = 1:size(hwaytyperaw)
   if strcmp(hwaytyperaw{i,1},'')
       hwaytyperaw{i,1} = NaN;
   end
end

hwytyperaw = cell2mat(hwaytyperaw);


htmatraw = zeros(length(hwytyperaw),2);
htmatraw(:,1) = hwytyperaw;

counter =1;
for i = 1: length(htmatraw)

% The following assignment for highway type is based on the U.S. DOT
% procedure (Source: U.S. DOT, 2007. Rail-Highway Grade Crossing Handbook)

%Rural Highway

    if  htmatraw(i,1)==01 
        htmatraw(i,2)= 1;
        counter=counter+htmatraw(i,1);
    
    elseif htmatraw(i,1)==02 
        htmatraw(i,2)= 2;
        counter=counter+htmatraw(i,1);    
        
    elseif htmatraw(i,1)==06 
        htmatraw(i,2)= 3;
        counter=counter+htmatraw(i,1);
    
    elseif htmatraw(i,1)==07 
        htmatraw(i,2)= 4;
        counter=counter+htmatraw(i,1);
        
    elseif htmatraw(i,1)==08 
        htmatraw(i,2)= 5;
        counter=counter+htmatraw(i,1);
        
    elseif htmatraw(i,1)==09 
        htmatraw(i,2)= 6;
        counter=counter+htmatraw(i,1);
        
%Urban Highway
       
    elseif htmatraw(i,1)==11 
        htmatraw(i,2)= 1;
        counter=counter+htmatraw(i,1);
    
    elseif htmatraw(i,1)==12 
        htmatraw(i,2)= 2;
        counter=counter+htmatraw(i,1);    
        
    elseif htmatraw(i,1)==14 
        htmatraw(i,2)= 3;
        counter=counter+htmatraw(i,1);
    
    elseif htmatraw(i,1)==16 
        htmatraw(i,2)= 4;
        counter=counter+htmatraw(i,1);
        
    elseif htmatraw(i,1)==17 
        htmatraw(i,2)= 5;
        counter=counter+htmatraw(i,1);
        
    elseif htmatraw(i,1)==19 
        htmatraw(i,2)= 6;
        counter=counter+htmatraw(i,1);
        
    else htmatraw(i,2)= 1;
        counter=counter+htmatraw(i,1);   
    end
end
  
htraw = htmatraw(:,2);

%=========================================================================%
% Raw Data for Number of Traffic lanes
%=========================================================================%
nolraw = table2array(DataFile(:,12));

for i = 1:size(nolraw)
   if strcmp(nolraw{i,1},'')
       nolraw{i,1} = NaN;
   end
end

nlraw = cell2mat(nolraw);

%=========================================================================%
% Raw Data for Average Number of Accidents per Year
%=========================================================================%
%Number of Years of Analysis Considered; 'T_years'
T_years = 5; 

Nmatraw = table2array(DataFile(:,19));
Nraw = Nmatraw./T_years;

%=========================================================================%
% Raw Data for the 2016-2007 accident data and 2017 accident data
%=========================================================================%
AHallraw = table2array(DataFile(:,25));
AHallraw(isnan(AHallraw))=0;

%=========================================================================%
% Raw Data for Accident history – 10 year accident history
%=========================================================================%
AH10raw = table2array(DataFile(:,24));
AH10raw(isnan(AH10raw))=0;

%=========================================================================%
% Raw Data for Accident history – 5 year accident history
%=========================================================================%
AH5raw = table2array(DataFile(:,19));
AH5raw(isnan(AH5raw))=0;

%=========================================================================%
% Raw Data for Accident history – current complete year
%=========================================================================%
ObservedAccraw = table2array(DataFile(:,26));
ObservedAccraw(isnan(ObservedAccraw))=0;

%=========================================================================%
% Raw Data for Accident history – 5 year accident history between 2016 &
% 2012 for USDOT Model
%=========================================================================%
AH5_USDOTraw = table2array(DataFile(:,27));
AH5_USDOTraw(isnan(AH5_USDOTraw))=0;

%=========================================================================%
% Raw Data for Accident history between 2016-2007
%=========================================================================%
AH2007raw = table2array(DataFile(:,24));
AH2007raw(isnan(AH2007raw))=0;
AH2008raw = table2array(DataFile(:,23));
AH2008raw(isnan(AH2008raw))=0;
AH2009raw = table2array(DataFile(:,22));
AH2009raw(isnan(AH2009raw))=0;
AH2010raw = table2array(DataFile(:,21));
AH2010raw(isnan(AH2010raw))=0;
AH2011raw = table2array(DataFile(:,20));
AH2011raw(isnan(AH2011raw))=0;
AH2012raw = table2array(DataFile(:,19));
AH2012raw(isnan(AH2012raw))=0;
AH2013raw = table2array(DataFile(:,18));
AH2013raw(isnan(AH2013raw))=0;
AH2014raw = table2array(DataFile(:,17));
AH2014raw(isnan(AH2014raw))=0;
AH2015raw = table2array(DataFile(:,16));
AH2015raw(isnan(AH2015raw))=0;
AH2016raw = table2array(DataFile(:,15));
AH2016raw(isnan(AH2016raw))=0;

%=========================================================================%
% Raw Data for Installation Date of Current Active Warning Devices
%=========================================================================%
dateraw = table2array(DataFile(:,14));

for i = 1:size(dateraw)
   if strcmp(dateraw{i,1},'')
       dateraw{i,1} = 0;
   end

end

AwdIDatevalraw = cell2mat(dateraw);

for k = 1:size(AwdIDatevalraw)
   if AwdIDatevalraw(k,1) == -1;
       AwdIDatevalraw(k,1) = 0;
   end
end

AwdIDatestrraw = num2str(AwdIDatevalraw);
AwdIDateraw = cellstr(AwdIDatestrraw);
%=========================================================================%

%=========================================================================%
% Raw Data for Crossing type
%=========================================================================%
PosXingraw = table2array(DataFile(:,28));

%% Clean the Data File by removing NaNs
DataFileClean = table(CrossingIDraw, Protectionraw, Vraw, Traw, msraw, Craw, MainTrkraw, HwyClassCDraw, draw, hpraw, htraw, nlraw, Nraw, AH10raw, AH5raw, ObservedAccraw, AH2007raw, AH2008raw, AH2009raw, AH2010raw, AH2011raw, AH2012raw, AH2013raw, AH2014raw, AH2015raw, AH2016raw, AH5_USDOTraw, AHallraw, AwdIDateraw, PosXingraw);
DataFileClean(any(ismissing(DataFileClean),2), :) = [];

% Remove all other types of crossings, which are not at-grade crossings 
% (i.e. RR under (code = 2) and RR Over (code = 3)) if any.
DataFileClean(DataFileClean.PosXingraw>1,:)=[];

%=========================================================================%
%Crossing ID 'CrossingID'
%=========================================================================%
CrossingID_AH = table2cell(DataFileClean(:,1));

%=========================================================================%
%Protection Type 'Protection'
%=========================================================================%
Protection_AH = table2cell(DataFileClean(:,2));

%=========================================================================%
%Average Annual Daily Traffic 'V'
%=========================================================================%
V_AH = table2array(DataFileClean(:,3));

%=========================================================================%
%Trains per day 'T'
%=========================================================================%
T_AH = table2array(DataFileClean(:,4));

%=========================================================================%
%Maximum Timetable Speed 'ms'
%=========================================================================%
ms_AH = table2array(DataFileClean(:,5));

%=========================================================================%
%Number of Main and Other Tracks; 'C'
%=========================================================================%
C_AH = table2array(DataFileClean(:,6));

%=========================================================================%
%Number of Main Tracks; 'MainTrk'
%=========================================================================%
MainTrk_AH = table2array(DataFileClean(:,7));

%=========================================================================%
%Classification of Road at Crossing; 'HwyClassCD'
%=========================================================================%
HwyClassCD_AH = table2array(DataFileClean(:,8));

%=========================================================================%
%Number of Through Trains per Day during Daylight; 'd'
%=========================================================================%
d_AH = table2array(DataFileClean(:,9));

%=========================================================================%
%Highway Paved; 'hp'
%=========================================================================%
hp_AH = table2array(DataFileClean(:,10));

%=========================================================================%
%Highway Type; 'ht'
%=========================================================================%
ht_AH = table2array(DataFileClean(:,11));

%=========================================================================%
%Number of Traffic lanes; 'nl'
%=========================================================================%
nl_AH = table2array(DataFileClean(:,12));

%=========================================================================%
%Average Number of Accidents per Year; 'N'
%=========================================================================%
N_AH = table2array(DataFileClean(:,13));

%=========================================================================%
% Accident history – 10 year accident history; 'AH10'
%=========================================================================%
AH10_AH = table2array(DataFileClean(:,14));

%=========================================================================%
% Accident history – 5 year accident history; 'AH5'
%=========================================================================%
AH5_AH = table2array(DataFileClean(:,15));

%=========================================================================%
% Accident history – current complete year; 'ObservedAcc'
%=========================================================================%
ObservedAcc_AH = table2array(DataFileClean(:,16));

%=========================================================================%
% Accident history between 2016-2007
%=========================================================================%
AH2007_AH = table2array(DataFileClean(:,17));

AH2008_AH = table2array(DataFileClean(:,18));

AH2009_AH = table2array(DataFileClean(:,19));

AH2010_AH = table2array(DataFileClean(:,20));

AH2011_AH = table2array(DataFileClean(:,21));

AH2012_AH = table2array(DataFileClean(:,22));

AH2013_AH = table2array(DataFileClean(:,23));

AH2014_AH = table2array(DataFileClean(:,24));

AH2015_AH = table2array(DataFileClean(:,25));

AH2016_AH = table2array(DataFileClean(:,26));

%=========================================================================%
% Accident history – 5 year accident history between 2016 & 2012 for USDOT Model
%=========================================================================%
AH5_USDOT_AH = table2array(DataFileClean(:,27));

%=========================================================================%
% Accident history for the 2016-2007 accident data and 2017 accident data
%=========================================================================%
AH_COM_AH = table2cell(DataFileClean(:,28));

%=========================================================================%
% Installation Date of Current Active Warning Devices; 'AwdIDate'
%=========================================================================%
AwdIDate_AH = table2cell(DataFileClean(:,29));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REQUIRED DATA WITH TOP 50 ACTIVE AND TOP 50 PASSIVE HIGHWAY-RAIL GRADE CROSSINGS

%% Create a table with only highway-rail grade crossings
FloridaCrossingsdata = cell2table(FloridaCrossings, 'VariableNames',Heading(1,:));

% Remove crossings with railroad (RR) Under
FloridaCrossingsdata(FloridaCrossingsdata.PosXing == 2, :) = []; 

% Remove crossings with RR Over
FloridaCrossingsdata(FloridaCrossingsdata.PosXing == 3, :) = [];

%% Data required from Crossing Inventory Database
Crossing_Inventory = FloridaCrossingsdata(:,{'CrossingID','WdCode', 'Aadt', 'DayThru', 'NghtThru', 'TotalSwt',...
    'MaxTtSpd', 'MainTrk', 'OthrTrk', 'HwyClassCD', 'HwyPved', 'TraficLn','HwyClassrdtpID', 'AwdIDate','PosXing'});

Crossing_Inventory_AP = Crossing_Inventory; 

%=========================================================================%
%Crossing ID from Raw Crossing_Inventory_AP
%=========================================================================%
CrossingID_AP = table2cell(Crossing_Inventory_AP(:,1));

%=========================================================================%
% Raw Data for Protection Type
%=========================================================================%
Protection_AP = table2cell(Crossing_Inventory_AP(:,2));

% If no protection is reported at a highway-rail-grade crossing assume a 
% value of '1' from the WdCode which denotes 'No signs or signal'
for i = 1:size(Protection_AP)
   if strcmp(Protection_AP{i,1},'')
       Protection_AP{i,1} = 1;
   end
end

Protection_AP = cell2mat(Protection_AP);

%=========================================================================%
% Raw Data for Average Annual Daily Traffic
%=========================================================================%
AADT_AP = table2array(Crossing_Inventory_AP(:,3));

for i = 1:size(AADT_AP)
   if strcmp(AADT_AP{i,1},'')
       AADT_AP{i,1} = NaN;
   end
end
 
V_AP = cell2mat(AADT_AP);

%=========================================================================%
% Raw Data for Trains per day
%=========================================================================%
Trainsperday_AP = table2array(Crossing_Inventory_AP(:,4:6));

%Replace negative numbers in the cell with zero
for i = 1:numel(Trainsperday_AP(:,1))
  M        = Trainsperday_AP{i};
  M(M > 0) = 0;
  %Trainsperday_AP{i}    = -M;
end

%Remove Null
for i = 1:numel(Trainsperday_AP(:,1))
   if strcmp(Trainsperday_AP{i,1},'NULL')
       Trainsperday_AP{i,1} = 0;
   end
end

for i = 1:numel(Trainsperday_AP(:,1))    
   if strcmp(Trainsperday_AP{i,2},'NULL')
       Trainsperday_AP{i,2} = 0; 
   end
end
   
for i = 1:numel(Trainsperday_AP(:,1))
   if strcmp(Trainsperday_AP{i,3},'NULL')
       Trainsperday_AP{i,3} = 0;
   end
end

T_AP = cell2mat(Trainsperday_AP(:,1)) + cell2mat(Trainsperday_AP(:,2)) + cell2mat(Trainsperday_AP(:,3));

%=========================================================================%
% Raw Data for Maximum Timetable Speed
%=========================================================================%
mtspeed_AP = table2array(Crossing_Inventory_AP(:,7));

for i = 1:numel(mtspeed_AP)
   if strcmp(mtspeed_AP{i,1},'NULL')
       mtspeed_AP{i,1} = 0;
   end
end

for i = 1:numel(mtspeed_AP)
   if strcmp(mtspeed_AP{i,1},'')
       mtspeed_AP{i,1} = 0;
   end
end

ms_AP = cell2mat (mtspeed_AP);

%=========================================================================%
% Raw Data for Number of Main and Other Tracks
%=========================================================================%
Nofmandotrks_AP = table2array(Crossing_Inventory_AP(:,8:9));
mo1_AP = cell2mat(Nofmandotrks_AP(:,1));
mo2_AP = Nofmandotrks_AP(:,2);

for i = 1:size(mo2_AP)
   if strcmp(mo2_AP{i,1},'NULL')
       mo2_AP{i,1} = 0;
   end
end
 
mo2_AP = cell2mat(mo2_AP);
C_AP = mo1_AP + mo2_AP;

%=========================================================================%
% Raw Data for Number of Main Tracks
%=========================================================================%
Maintracks_AP = table2array(Crossing_Inventory_AP(:,8));
MainTrk_AP = cell2mat(Maintracks_AP);

%=========================================================================%
% Raw Data for Classification of Road at Crossing
%=========================================================================%
HwyClass_AP = table2array(Crossing_Inventory_AP(:,10));

for i = 1:size(HwyClass_AP)
   if strcmp(HwyClass_AP{i,1},'')
       HwyClass_AP{i,1} = NaN;
   end
end

HwyClassCD_AP = cell2mat(HwyClass_AP);

%=========================================================================%
% Raw Data for Number of Through Trains per Day during Daylight
%=========================================================================%
d_AP = cell2mat(Trainsperday_AP(:,1));

%=========================================================================%
% Raw Data for Highway Paved 
%=========================================================================%
hpaved_AP = table2array(Crossing_Inventory_AP(:,11));

for i = 1:size(hpaved_AP)
   if strcmp(hpaved_AP{i,1},'')
       hpaved_AP{i,1} = NaN;
   end
end

hp_AP = cell2mat(hpaved_AP);
hp_AP(isnan(hp_AP))=0;

%=========================================================================%
% Raw Data for Highway Type
%=========================================================================%
hwaytype_AP = table2array(Crossing_Inventory_AP(:,13));

for i = 1:size(hwaytype_AP)
   if strcmp(hwaytype_AP{i,1},'')
       hwaytype_AP{i,1} = NaN;
   end
end

hwytype_AP = cell2mat(hwaytype_AP);


htmat_AP = zeros(length(hwytype_AP),2);
htmat_AP(:,1) = hwytype_AP;

counter =1;
for i = 1: length(htmat_AP)

% The following assignment for highway type is based on the U.S. DOT
% procedure

%Rural Highway

    if  htmat_AP(i,1)==01 
        htmat_AP(i,2)= 1;
        counter=counter+htmat_AP(i,1);
    
    elseif htmat_AP(i,1)==02 
        htmat_AP(i,2)= 2;
        counter=counter+htmat_AP(i,1);    
        
    elseif htmat_AP(i,1)==06 
        htmat_AP(i,2)= 3;
        counter=counter+htmat_AP(i,1);
    
    elseif htmat_AP(i,1)==07 
        htmat_AP(i,2)= 4;
        counter=counter+htmat_AP(i,1);
        
    elseif htmat_AP(i,1)==08 
        htmat_AP(i,2)= 5;
        counter=counter+htmat_AP(i,1);
        
    elseif htmat_AP(i,1)==09 
        htmat_AP(i,2)= 6;
        counter=counter+htmat_AP(i,1);
        
%Urban Highway
       
    elseif htmat_AP(i,1)==11 
        htmat_AP(i,2)= 1;
        counter=counter+htmat_AP(i,1);
    
    elseif htmat_AP(i,1)==12 
        htmat_AP(i,2)= 2;
        counter=counter+htmat_AP(i,1);    
        
    elseif htmat_AP(i,1)==14 
        htmat_AP(i,2)= 3;
        counter=counter+htmat_AP(i,1);
    
    elseif htmat_AP(i,1)==16 
        htmat_AP(i,2)= 4;
        counter=counter+htmat_AP(i,1);
        
    elseif htmat_AP(i,1)==17 
        htmat_AP(i,2)= 5;
        counter=counter+htmat_AP(i,1);
        
    elseif htmat_AP(i,1)==19 
        htmat_AP(i,2)= 6;
        counter=counter+htmat_AP(i,1);
        
    else htmat_AP(i,2)= 1;
        counter=counter+htmat_AP(i,1);   
    end
end
  
ht_AP = htmat_AP(:,2);

%=========================================================================%
% Raw Data for Number of Traffic lanes
%=========================================================================%
nol_AP = table2array(Crossing_Inventory_AP(:,12));

for i = 1:size(nol_AP)
   if strcmp(nol_AP{i,1},'')
       nol_AP{i,1} = NaN;
   end
end

nl_AP = cell2mat(nol_AP);

%=========================================================================%
% Raw Data for Installation Date of Current Active Warning Devices
%=========================================================================%
date_AP = table2array(Crossing_Inventory_AP(:,14));

for i = 1:size(date_AP)
   if strcmp(date_AP{i,1},'')
       date_AP{i,1} = 0;
   end

end

AwdIDateval_AP = cell2mat(date_AP);

for k = 1:size(AwdIDateval_AP)
   if AwdIDateval_AP(k,1) == -1;
       AwdIDateval_AP(k,1) = 0;
   end
end

AwdIDatestr_AP = num2str(AwdIDateval_AP);
AwdIDate_AP = cellstr(AwdIDatestr_AP);

%% Estimate exposure
Exposure = V_AP .* T_AP;

%% Clean the Data File by removing NaNs
Crossing_Inventory_APClean = table(CrossingID_AP, Protection_AP, V_AP, T_AP, ms_AP, C_AP, MainTrk_AP, HwyClassCD_AP, d_AP, hp_AP, ht_AP, nl_AP, AwdIDate_AP, Exposure);
Crossing_Inventory_APClean(any(ismissing(Crossing_Inventory_APClean),2), :) = [];

%% Remove crossings with accident history
CrossingID_all =CrossingID_AH;
Crossing_Inventory_AP_cell = table2cell(Crossing_Inventory_APClean);
Crossing_Inventory_APClean(ismember((Crossing_Inventory_AP_cell(:,1)),CrossingID_all), :) = [];

%% Select active highway-rail grade crossings only
Crossing_Inventory_Active_Select =(Crossing_Inventory_APClean);

Crossing_Inventory_Active_Select(Crossing_Inventory_Active_Select.Protection_AP < 5, :)=[]; 


%% Select passive highway-rail grade crossings only
Crossing_Inventory_Passive_Select =(Crossing_Inventory_APClean);

Crossing_Inventory_Passive_Select(Crossing_Inventory_Passive_Select.Protection_AP > 4, :)=[]; 

%% Sort Crossings based on exposure
% Active highway-rail grade crossings
Crossing_Inventory_Active_Sort = sortrows(Crossing_Inventory_Active_Select,{'Exposure'},{'descend'});

% Passive highway-rail grade crossings
Crossing_Inventory_Passive_Sort = sortrows(Crossing_Inventory_Passive_Select,{'Exposure'},{'descend'});

%% Select top 50 crossings
%Top 50 active highway-rail grade crossings 
Crossing_Inventory_Active = Crossing_Inventory_Active_Sort(1:50,:);

%Top 50 passive highway-rail grade crossings
Crossing_Inventory_Passive = Crossing_Inventory_Passive_Sort(1:50,:);

%%Final Data Values
%=========================================================================%
%Crossing ID 'CrossingID'
%=========================================================================%
CIA = (Crossing_Inventory_Active(:,1));
CIP = (Crossing_Inventory_Passive(:,1));
CrossInv_IDMat = [CIA;CIP];
CrossInv_IDMat = table2cell (CrossInv_IDMat);

CrossingID = [CrossingID_AH;CrossInv_IDMat];

%=========================================================================%
%Protection Type 'Protection'
%=========================================================================%
CIA_Proct = (Crossing_Inventory_Active(:,2));
CIP_Proct = (Crossing_Inventory_Passive(:,2));
CrossInv_ProtMat = [CIA_Proct;CIP_Proct];
CrossInv_ProtMat = table2cell(CrossInv_ProtMat);

Protection = [Protection_AH;CrossInv_ProtMat];

%Store the "Protection" values in the cell as strings
Protection = cellfun(@num2str, Protection, 'un', 0);

%=========================================================================%
%Average Annual Daily Traffic 'V'
%=========================================================================%
CIA_V = (Crossing_Inventory_Active(:,3));
CIP_V = (Crossing_Inventory_Passive(:,3));
CrossInv_V = [CIA_V;CIP_V];
CrossInv_V = table2array(CrossInv_V);

V = [V_AH;CrossInv_V];

%=========================================================================%
%Trains per day 'T'
%=========================================================================%
CIA_T = (Crossing_Inventory_Active(:,4));
CIP_T = (Crossing_Inventory_Passive(:,4));
CrossInv_T = [CIA_T;CIP_T];
CrossInv_T = table2array(CrossInv_T);

T = [T_AH;CrossInv_T];

%=========================================================================%
%Maximum Timetable Speed 'ms'
%=========================================================================%
CIA_ms = (Crossing_Inventory_Active(:,5));
CIP_ms = (Crossing_Inventory_Passive(:,5));
CrossInv_ms = [CIA_ms;CIP_ms];
CrossInv_ms = table2array(CrossInv_ms);

ms = [ms_AH;CrossInv_ms];

%=========================================================================%
%Number of Main and Other Tracks; 'C'
%=========================================================================%
CIA_C = (Crossing_Inventory_Active(:,6));
CIP_C = (Crossing_Inventory_Passive(:,6));
CrossInv_C = [CIA_C;CIP_C];
CrossInv_C = table2array(CrossInv_C);

C = [C_AH;CrossInv_C];

%=========================================================================%
%Number of Main Tracks; 'MainTrk'
%=========================================================================%
CIA_MainTrk = (Crossing_Inventory_Active(:,7));
CIP_MainTrk = (Crossing_Inventory_Passive(:,7));
CrossInv_MainTrk = [CIA_MainTrk;CIP_MainTrk];
CrossInv_MainTrk = table2array(CrossInv_MainTrk);

MainTrk = [MainTrk_AH;CrossInv_MainTrk];

%=========================================================================%
%Classification of Road at Crossing; 'HwyClassCD'
%=========================================================================%
CIA_HwyClassCD = (Crossing_Inventory_Active(:,8));
CIP_HwyClassCD = (Crossing_Inventory_Passive(:,8));
CrossInv_HwyClassCD = [CIA_HwyClassCD;CIP_HwyClassCD];
CrossInv_HwyClassCD = table2array(CrossInv_HwyClassCD);

HwyClassCD = [HwyClassCD_AH;CrossInv_HwyClassCD];

%=========================================================================%
%Number of Through Trains per Day during Daylight; 'd'
%=========================================================================%
CIA_d = (Crossing_Inventory_Active(:,9));
CIP_d = (Crossing_Inventory_Passive(:,9));
CrossInv_d = [CIA_d;CIP_d];
CrossInv_d = table2array(CrossInv_d);

d = [d_AH;CrossInv_d];

%=========================================================================%
%Highway Paved; 'hp'
%=========================================================================%
CIA_hp = (Crossing_Inventory_Active(:,10));
CIP_hp = (Crossing_Inventory_Passive(:,10));
CrossInv_hp = [CIA_hp;CIP_hp];
CrossInv_hp = table2array(CrossInv_hp);

hp = [hp_AH;CrossInv_hp];

%=========================================================================%
%Highway Type; 'ht'
%=========================================================================%
CIA_ht = (Crossing_Inventory_Active(:,11));
CIP_ht = (Crossing_Inventory_Passive(:,11));
CrossInv_ht = [CIA_ht;CIP_ht];
CrossInv_ht = table2array(CrossInv_ht);

ht = [ht_AH;CrossInv_ht];

%=========================================================================%
%Number of Traffic lanes; 'nl'
%=========================================================================%
CIA_nl = (Crossing_Inventory_Active(:,12));
CIP_nl = (Crossing_Inventory_Passive(:,12));
CrossInv_nl = [CIA_nl;CIP_nl];
CrossInv_nl = table2array(CrossInv_nl);

nl = [nl_AH;CrossInv_nl];

%=========================================================================%
%Average Number of Accidents per Year; 'N'
%=========================================================================%
CIA_N = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_N = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
 
N = [N_AH;CIA_N;CIP_N];

%=========================================================================%
% Accident history – 10 year accident history; 'AH10'
%=========================================================================%
CIA_AH10 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH10 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
 
AH10 = [AH10_AH;CIA_AH10;CIP_AH10];

%=========================================================================%
% Accident history – 5 year accident history; 'AH5'
%=========================================================================%
CIA_AH5 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH5 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
 
AH5 = [AH5_AH;CIA_AH5;CIP_AH5];

%=========================================================================%
% Accident history – current complete year; 'ObservedAcc'
%=========================================================================%
CIA_ObservedAcc = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_ObservedAcc = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
 
ObservedAcc = [ObservedAcc_AH;CIA_ObservedAcc;CIP_ObservedAcc];

%=========================================================================%
% Accident history between 2016-2007
%=========================================================================%
CIA_AH2007 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2007 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2007 = [AH2007_AH;CIA_AH2007;CIP_AH2007];

CIA_AH2008 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2008 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2008 = [AH2008_AH;CIA_AH2008;CIP_AH2008];

CIA_AH2009 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2009 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2009 = [AH2009_AH;CIA_AH2009;CIP_AH2009];

CIA_AH2010 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2010 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2010 = [AH2010_AH;CIA_AH2010;CIP_AH2010];

CIA_AH2011 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2011 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2011 = [AH2011_AH;CIA_AH2011;CIP_AH2011];

CIA_AH2012 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2012 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2012 = [AH2012_AH;CIA_AH2012;CIP_AH2012];

CIA_AH2013 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2013 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2013 = [AH2013_AH;CIA_AH2013;CIP_AH2013];

CIA_AH2014 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2014 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2014 = [AH2014_AH;CIA_AH2014;CIP_AH2014];

CIA_AH2015 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2015 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2015 = [AH2015_AH;CIA_AH2015;CIP_AH2015];

CIA_AH2016 = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH2016 = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
AH2016 = [AH2016_AH;CIA_AH2016;CIP_AH2016];

%=========================================================================%
% Accident history – 5 year accident history between 2016 & 2012 for USDOT Model
%=========================================================================%
CIA_AH5_USDOT = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH5_USDOT = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
 
AH5_USDOT = [AH5_USDOT_AH;CIA_AH5_USDOT;CIP_AH5_USDOT];

%=========================================================================%
% Accident history for the 2016-2007 accident data and 2017 accident data
%=========================================================================%
CIA_AH_COM = zeros((numel(Crossing_Inventory_Active(:,2))),1);
CIP_AH_COM = zeros((numel(Crossing_Inventory_Passive(:,2))),1);
 
AH_COM = [AH5_USDOT_AH;CIA_AH_COM;CIP_AH_COM];

%=========================================================================%
% Installation Date of Current Active Warning Devices; 'AwdIDate'
%=========================================================================%
CIA_AwdIDate = (Crossing_Inventory_Active(:,13));
CIP_AwdIDate = (Crossing_Inventory_Passive(:,13));
CrossInv_AwdIDate = [CIA_AwdIDate;CIP_AwdIDate];
CrossInv_AwdIDate = table2cell(CrossInv_AwdIDate);

AwdIDate = [AwdIDate_AH;CrossInv_AwdIDate];

%% Key Assumptions

% If the AADT is less than 1, assume a value of 1
V = max(1, V); 

% If the total number of trains per day is less than 1, assume a value of 1
T = max(1, T); 

% If the maximum timetable speed is less than 1 mph, assume a value of 1 mph.
ms = max(1, ms); 

% If the number of main and other tracks is less than 1, assume a value of 1
C = max(1, C); 

% If the number of main tracks is less than 1, 
MainTrk = max(1, MainTrk); 

% If the number of highway lanes is less than 1, assume a value of 1
nl = max(1, nl); 

%=========================================================================%
%  Remove auxiliary data and keep only the information required by the
%  accident/hazard prediction models
%=========================================================================%

save('Required_Data','CrossingID','Protection','V','T','ms','C','MainTrk',...
'HwyClassCD','d','hp','ht','nl','N','AH10','AH5','ObservedAcc','AH2007','AH2008',... 
'AH2009','AH2010','AH2011','AH2012','AH2013','AH2014','AH2015','AH2016','AH5_USDOT','AH_COM','AwdIDate');

clear; load('Required_Data.mat');delete('Required_Data.mat');
