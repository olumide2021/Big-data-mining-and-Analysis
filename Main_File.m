%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hazard Prediction Formulae
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%

%=========================================================================%
% New Hampshire Formula 
%=========================================================================%
NHHI_values = New_Hamp_Haz_Ind(Protection, V, T);

%=========================================================================%
% California Hazard Rating Formula 
%=========================================================================%
CaHI_values = Cali_Haz_Rat(Protection, V, T, AH10);

%=========================================================================%
% Modified California Hazard Rating Formula 
%=========================================================================%
Modified_CaHI_values = Modified_Cali_Haz_Rat(Protection, V, T, AH10, AwdIDate, AH2016, AH2015, AH2014, AH2013, AH2012, AH2011, AH2010, AH2009, AH2008);

%=========================================================================%
% Connecticut Hazard rating Formula 
%=========================================================================%
CoHI_values = Connect_Haz_Rat(Protection, V, T, AH5);

%=========================================================================%
% Modified Connecticut Hazard rating Formula 
%=========================================================================%
Modified_CoHI_values = Modified_Connect_Haz_Rat(Protection, V, T, AH5, AwdIDate, AH2016, AH2015, AH2014, AH2013);

%=========================================================================%
% Illinois Hazard Index Formula 
%=========================================================================%
IHI_values = Illinois_Haz_Ind(Protection, V, T, ms, C, nl, N);

%=========================================================================%
% Michigan Hazard Index Formula 
%=========================================================================%
MHI_values = Mich_Haz_Ind(Protection, V, T);

%=========================================================================%
% Texas Priority Index Formula 
%=========================================================================%
TPI_values = Texas_Pri_Ind(Protection, V, T, ms, AH5);

%=========================================================================%
% Modified Texas Priority Index Formula 
%=========================================================================%
Modified_TPI_values = Modified_Texas_Pri_Ind(Protection, V, T, ms, AH5, AwdIDate, AH2016, AH2015, AH2014, AH2013);

%=========================================================================%
% Hazard Prediction Formulae Values
%=========================================================================%
Hazard_Prediction = table(NHHI_values, CaHI_values, Modified_CaHI_values, CoHI_values, Modified_CoHI_values, IHI_values,  MHI_values,  TPI_values, Modified_TPI_values)


%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accident Prediction Formulae
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%

%=========================================================================%
% Coleman Stewart Model 
%=========================================================================%
CS_values = Cole_Stew(Protection, MainTrk, HwyClassCD, V, T);

%=========================================================================%
% NCHRP Report 50 Accident Prediction Formula 
%=========================================================================%
NCHRP_values = NCHRP_Rep50(Protection, V, T, HwyClassCD);

%====================1=====================================================%
%Peabody Dimmick Formula 
%=========================================================================%
PD_values = Peabody_Dimmick(Protection, V, T);

%=========================================================================%
% US DOT Formula 
%=========================================================================%
[USDOT_Initial, USDOT_Second, USDOT_Final, NC_PSV, NC_FLS, NC_GTS] = USDOT_model(Protection, V, T, MainTrk, d, hp, ms, ht, nl, ObservedAcc, AwdIDate, AH2016, AH2015, AH2014, AH2013, AH5_USDOT);

% Normalizing Constants
varNames = {'Passive', 'Flashing_Lights', 'Gates'};
Normalizing_Constants = table (NC_PSV, NC_FLS, NC_GTS,'VariableNames',varNames);

% Final Accident Prediction Values for USDOT Model
USDOT_values = USDOT_Final;

%=========================================================================%
% Accident Prediction Formulae Values
%=========================================================================%
Accident_Prediction = table(CS_values, NCHRP_values, PD_values, USDOT_values)


%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Ranking of Crossings                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%
%=========================================================================%
% Ranking of Crossings Based on Actual Accident Data
%=========================================================================%
RankMatUnsorted = {};
RankMatUnsorted(:, 1) = num2cell(ObservedAcc);
RankMatUnsorted(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted(:, 3) = CrossingID;

RankMat = sortrows(RankMatUnsorted,[-1 -2]);

[~,Rank_Actual] = ismember(CrossingID, RankMat(:,3));

clear RankMatUnsorted RankMat;

%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ranking of Crossings Based on the Candidate Accident/Hazard Prediction
% Formulae, Using Exposure as a Secondary Ranking Criterion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%

%=========================================================================%
% Ranking Based on New Hampshire Formula
%=========================================================================%
RankMatUnsorted_NHHI = {};
RankMatUnsorted_NHHI(:, 1) = num2cell(NHHI_values);
RankMatUnsorted_NHHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_NHHI(:, 3) = CrossingID;

RankMat_NHHI = sortrows(RankMatUnsorted_NHHI,[-1 -2]);

[~,Rank_NHHI] = ismember(CrossingID, RankMat_NHHI(:,3));

clear RankMatUnsorted_NHHI RankMat_NHHI;

%=========================================================================%
% Ranking Based on California Hazard Rating Formula
%=========================================================================%
RankMatUnsorted_CaHI = {};
RankMatUnsorted_CaHI(:, 1) = num2cell(CaHI_values);
RankMatUnsorted_CaHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_CaHI(:, 3) = CrossingID;

RankMat_CaHI = sortrows(RankMatUnsorted_CaHI,[-1 -2]);

[~,Rank_CaHI] = ismember(CrossingID, RankMat_CaHI(:,3));

clear RankMatUnsorted_CaHI RankMat_CaHI;

%=========================================================================%
% Ranking Based on Modified California Hazard Rating Formula
%=========================================================================%
RankMatUnsorted_Modified_CaHI = {};
RankMatUnsorted_Modified_CaHI(:, 1) = num2cell(Modified_CaHI_values);
RankMatUnsorted_Modified_CaHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_Modified_CaHI(:, 3) = CrossingID;

RankMat_Modified_CaHI = sortrows(RankMatUnsorted_Modified_CaHI,[-1 -2]);

[~,Rank_Modified_CaHI] = ismember(CrossingID, RankMat_Modified_CaHI(:,3));

clear RankMatUnsorted_Modified_CaHI RankMat_Modified_CaHI;

%=========================================================================%
% Ranking Based on Connecticut Hazard Rating Formula
%=========================================================================%
RankMatUnsorted_CoHI = {};
RankMatUnsorted_CoHI(:, 1) = num2cell(CoHI_values);
RankMatUnsorted_CoHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_CoHI(:, 3) = CrossingID;

RankMat_CoHI = sortrows(RankMatUnsorted_CoHI,[-1 -2]);

[~,Rank_CoHI] = ismember(CrossingID, RankMat_CoHI(:,3));

clear RankMatUnsorted_CoHI RankMat_CoHI;

%=========================================================================%
% Ranking Based on Modified Connecticut Hazard Rating Formula
%=========================================================================%
RankMatUnsorted_Modified_CoHI = {};
RankMatUnsorted_Modified_CoHI(:, 1) = num2cell(Modified_CoHI_values);
RankMatUnsorted_Modified_CoHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_Modified_CoHI(:, 3) = CrossingID;

RankMat_Modified_CoHI = sortrows(RankMatUnsorted_Modified_CoHI,[-1 -2]);

[~,Rank_Modified_CoHI] = ismember(CrossingID, RankMat_Modified_CoHI(:,3));

clear RankMatUnsorted_Modified_CoHI RankMat_Modified_CoHI;

%=========================================================================%
% Ranking Based on Illinois Hazard Index Formula
%=========================================================================%
RankMatUnsorted_IHI = {};
RankMatUnsorted_IHI(:, 1) = num2cell(IHI_values);
RankMatUnsorted_IHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_IHI(:, 3) = CrossingID;

RankMat_IHI = sortrows(RankMatUnsorted_IHI,[-1 -2]);

[~,Rank_IHI] = ismember(CrossingID, RankMat_IHI(:,3));

clear RankMatUnsorted_IHI RankMat_IHI;

%=========================================================================%
% Ranking Based on Michigan Hazard Index Formula
%=========================================================================%
RankMatUnsorted_MHI = {};
RankMatUnsorted_MHI(:, 1) = num2cell(MHI_values);
RankMatUnsorted_MHI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_MHI(:, 3) = CrossingID;

RankMat_MHI = sortrows(RankMatUnsorted_MHI,[-1 -2]);

[~,Rank_MHI] = ismember(CrossingID, RankMat_MHI(:,3));

clear RankMatUnsorted_MHI RankMat_MHI;

%=========================================================================%
% Ranking Based on Texas Priority Index Formula
%=========================================================================%
RankMatUnsorted_TPI = {};
RankMatUnsorted_TPI(:, 1) = num2cell(TPI_values);
RankMatUnsorted_TPI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_TPI(:, 3) = CrossingID;

RankMat_TPI = sortrows(RankMatUnsorted_TPI,[-1 -2]);

[~,Rank_TPI] = ismember(CrossingID, RankMat_TPI(:,3));

clear RankMatUnsorted_TPI RankMat_TPI;

%=========================================================================%
% Ranking Based on Modified Texas Priority Index Formula
%=========================================================================%
RankMatUnsorted_Modified_TPI = {};
RankMatUnsorted_Modified_TPI(:, 1) = num2cell(Modified_TPI_values);
RankMatUnsorted_Modified_TPI(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_Modified_TPI(:, 3) = CrossingID;

RankMat_Modified_TPI = sortrows(RankMatUnsorted_Modified_TPI,[-1 -2]);

[~,Rank_Modified_TPI] = ismember(CrossingID, RankMat_Modified_TPI(:,3));

clear RankMatUnsorted_Modified_TPI RankMat_Modified_TPI;

%=========================================================================%
% Ranking Based on Coleman Stewart Model
%=========================================================================%
RankMatUnsorted_CS = {};
RankMatUnsorted_CS(:, 1) = num2cell(CS_values);
RankMatUnsorted_CS(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_CS(:, 3) = CrossingID;

RankMat_CS = sortrows(RankMatUnsorted_CS,[-1 -2]);

[~,Rank_CS] = ismember(CrossingID, RankMat_CS(:,3));

clear RankMatUnsorted_CS RankMat_CS;

%=========================================================================%
% Ranking Based on NCHRP Report 50 Accident Prediction Formula
%=========================================================================%
RankMatUnsorted_NCHRP = {};
RankMatUnsorted_NCHRP(:, 1) = num2cell(NCHRP_values);
RankMatUnsorted_NCHRP(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_NCHRP(:, 3) = CrossingID;

RankMat_NCHRP = sortrows(RankMatUnsorted_NCHRP,[-1 -2]);

[~,Rank_NCHRP] = ismember(CrossingID, RankMat_NCHRP(:,3));

clear RankMatUnsorted_NCHRP RankMat_NCHRP;

%=========================================================================%
% Ranking Based on Peabody Dimmick Formula
%=========================================================================%
RankMatUnsorted_PD = {};
RankMatUnsorted_PD(:, 1) = num2cell(PD_values);
RankMatUnsorted_PD(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_PD(:, 3) = CrossingID;

RankMat_PD = sortrows(RankMatUnsorted_PD,[-1 -2]);

[~,Rank_PD] = ismember(CrossingID, RankMat_PD(:,3));

clear RankMatUnsorted_PD RankMat_PD;

%=========================================================================%
% Ranking Based on U.S. DOT Formula
%=========================================================================%
RankMatUnsorted_USDOT = {};
RankMatUnsorted_USDOT(:, 1) = num2cell(USDOT_values);
RankMatUnsorted_USDOT(:, 2) = num2cell(V .* T); % Exposure = V .* T
RankMatUnsorted_USDOT(:, 3) = CrossingID;

RankMat_USDOT = sortrows(RankMatUnsorted_USDOT,[-1 -2]);

[~,Rank_USDOT] = ismember(CrossingID, RankMat_USDOT(:,3));

clear RankMatUnsorted_USDOT RankMat_USDOT;

%=========================================================================%

Ranking_of_Crossings = table(CrossingID, Rank_Actual, Rank_NHHI, Rank_CaHI, Rank_Modified_CaHI, Rank_CoHI, Rank_Modified_CoHI, Rank_IHI, Rank_MHI, Rank_TPI, Rank_Modified_TPI, Rank_CS, Rank_NCHRP, Rank_PD, Rank_USDOT)


%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Evaluation of the Candidate Accident/Hazard Prediction Formulae     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%

%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chi-Square Formula (only for the accident prediction formulae)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%
% Chi-Square for Coleman Stewart Model
clean_ChiSq_CS = ((ObservedAcc - CS_values).^2) ./ CS_values; %Might contain NaN and Inf 
clean_ChiSq_CS = clean_ChiSq_CS(~isnan(clean_ChiSq_CS)); % Removes NaN
clean_ChiSq_CS = clean_ChiSq_CS(~isinf(clean_ChiSq_CS)); % Removes Inf
ChiSq_CS = sum(clean_ChiSq_CS);

% Chi-Square for NCHRP Report 50 Accident Prediction Formula
clean_ChiSq_NCHRP = ((ObservedAcc - NCHRP_values).^2) ./ NCHRP_values; %Might contain NaN and Inf 
clean_ChiSq_NCHRP = clean_ChiSq_NCHRP(~isnan(clean_ChiSq_NCHRP)); % Removes NaN
clean_ChiSq_NCHRP = clean_ChiSq_NCHRP(~isinf(clean_ChiSq_NCHRP)); % Removes Inf
ChiSq_NCHRP = sum(clean_ChiSq_NCHRP);

% Chi-Square for Peabody Dimmick Formula
clean_ChiSq_PD = ((ObservedAcc - (PD_values/5)).^2) ./ (PD_values/5); %Might contain NaN and Inf 
clean_ChiSq_PD = clean_ChiSq_PD(~isnan(clean_ChiSq_PD)); % Removes NaN
clean_ChiSq_PD = clean_ChiSq_PD(~isinf(clean_ChiSq_PD)); % Removes Inf
ChiSq_PD = sum(clean_ChiSq_PD);

% Chi-Square for U.S. DOT Formula
clean_ChiSq_USDOT = ((ObservedAcc - USDOT_values).^2) ./ USDOT_values; %Might contain NaN and Inf 
clean_ChiSq_USDOT = clean_ChiSq_USDOT(~isnan(clean_ChiSq_USDOT)); % Removes NaN
clean_ChiSq_USDOT = clean_ChiSq_USDOT(~isinf(clean_ChiSq_USDOT)); % Removes Inf
ChiSq_USDOT = sum(clean_ChiSq_USDOT);

%=========================================================================%

Chi_Square = table(ChiSq_CS, ChiSq_NCHRP, ChiSq_PD, ChiSq_USDOT)


%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model Validation Using Actual Accident Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%
Crossing_Group1 = 0.05; Crossing_Group2 = 0.10; Crossing_Group3 = 0.20; Crossing_Group4 = 0.30; Crossing_Group5 = 0.40; Crossing_Group6 = 0.50;

%=========================================================================%
% Top 5%, 10%, 20%, 30%, 40%, and 50% Riskiest Crossings Based on Actual Accident Data
%=========================================================================%
ActMat = {};
ActMat(:,1) = CrossingID;
ActMat(:,2) = num2cell(Rank_Actual);
ActMatSorted = sortrows(ActMat, 2);
Group1_Actual = ActMatSorted(1:ceil(length(ActMatSorted)* Crossing_Group1));
Group2_Actual = ActMatSorted(1:ceil(length(ActMatSorted)* Crossing_Group2));
Group3_Actual = ActMatSorted(1:ceil(length(ActMatSorted)* Crossing_Group3));
Group4_Actual = ActMatSorted(1:ceil(length(ActMatSorted)* Crossing_Group4));
Group5_Actual = ActMatSorted(1:ceil(length(ActMatSorted)* Crossing_Group5));
Group6_Actual = ActMatSorted(1:ceil(length(ActMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_Actual = ActMatSorted(1:ceil(length(ActMatSorted)*UserDefinedPercent/100));

%=========================================================================%
% Percentage of Riskiest Crossings Captured by New Hampshire Formula
%=========================================================================%
NHHIMat = {};
NHHIMat(:,1) = CrossingID;
NHHIMat(:,2) = num2cell(Rank_NHHI);
NHHIMatSorted = sortrows(NHHIMat, 2);
Group1_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)* Crossing_Group1));
Group2_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)* Crossing_Group2));
Group3_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)* Crossing_Group3));
Group4_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)* Crossing_Group4));
Group5_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)* Crossing_Group5));
Group6_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_NHHI = NHHIMatSorted(1:ceil(length(NHHIMatSorted)*UserDefinedPercent/100));

NHHI_capture_Group1 = length(intersect(Group1_NHHI, Group1_Actual)) / length(Group1_Actual);
NHHI_capture_Group2 = length(intersect(Group2_NHHI, Group2_Actual)) / length(Group2_Actual);
NHHI_capture_Group3 = length(intersect(Group3_NHHI, Group3_Actual)) / length(Group3_Actual);
NHHI_capture_Group4 = length(intersect(Group4_NHHI, Group4_Actual)) / length(Group4_Actual);
NHHI_capture_Group5 = length(intersect(Group5_NHHI, Group5_Actual)) / length(Group5_Actual);
NHHI_capture_Group6 = length(intersect(Group6_NHHI, Group6_Actual)) / length(Group6_Actual);
%NHHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_NHHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by California Hazard Rating Formula
%=========================================================================%
CaHIMat = {};
CaHIMat(:,1) = CrossingID;
CaHIMat(:,2) = num2cell(Rank_CaHI);
CaHIMatSorted = sortrows(CaHIMat, 2);
Group1_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)* Crossing_Group1));
Group2_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)* Crossing_Group2));
Group3_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)* Crossing_Group3));
Group4_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)* Crossing_Group4));
Group5_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)* Crossing_Group5));
Group6_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_CaHI = CaHIMatSorted(1:ceil(length(CaHIMatSorted)*UserDefinedPercent/100));

CaHI_capture_Group1 = length(intersect(Group1_CaHI, Group1_Actual)) / length(Group1_Actual);
CaHI_capture_Group2 = length(intersect(Group2_CaHI, Group2_Actual)) / length(Group2_Actual);
CaHI_capture_Group3 = length(intersect(Group3_CaHI, Group3_Actual)) / length(Group3_Actual);
CaHI_capture_Group4 = length(intersect(Group4_CaHI, Group4_Actual)) / length(Group4_Actual);
CaHI_capture_Group5 = length(intersect(Group5_CaHI, Group5_Actual)) / length(Group5_Actual);
CaHI_capture_Group6 = length(intersect(Group6_CaHI, Group6_Actual)) / length(Group6_Actual);
%CaHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_CaHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Modified California Hazard Rating Formula
%=========================================================================%
Modified_CaHIMat = {};
Modified_CaHIMat(:,1) = CrossingID;
Modified_CaHIMat(:,2) = num2cell(Rank_Modified_CaHI);
Modified_CaHIMatSorted = sortrows(Modified_CaHIMat, 2);
Group1_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)* Crossing_Group1));
Group2_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)* Crossing_Group2));
Group3_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)* Crossing_Group3));
Group4_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)* Crossing_Group4));
Group5_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)* Crossing_Group5));
Group6_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_Modified_CaHI = Modified_CaHIMatSorted(1:ceil(length(Modified_CaHIMatSorted)*UserDefinedPercent/100));

Modified_CaHI_capture_Group1 = length(intersect(Group1_Modified_CaHI, Group1_Actual)) / length(Group1_Actual);
Modified_CaHI_capture_Group2 = length(intersect(Group2_Modified_CaHI, Group2_Actual)) / length(Group2_Actual);
Modified_CaHI_capture_Group3 = length(intersect(Group3_Modified_CaHI, Group3_Actual)) / length(Group3_Actual);
Modified_CaHI_capture_Group4 = length(intersect(Group4_Modified_CaHI, Group4_Actual)) / length(Group4_Actual);
Modified_CaHI_capture_Group5 = length(intersect(Group5_Modified_CaHI, Group5_Actual)) / length(Group5_Actual);
Modified_CaHI_capture_Group6 = length(intersect(Group6_Modified_CaHI, Group6_Actual)) / length(Group6_Actual);
%Modified_CaHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_Modified_CaHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Connecticut Hazard Rating Formula
%=========================================================================%
CoHIMat = {};
CoHIMat(:,1) = CrossingID;
CoHIMat(:,2) = num2cell(Rank_CoHI);
CoHIMatSorted = sortrows(CoHIMat, 2);
Group1_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)* Crossing_Group1));
Group2_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)* Crossing_Group2));
Group3_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)* Crossing_Group3));
Group4_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)* Crossing_Group4));
Group5_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)* Crossing_Group5));
Group6_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_CoHI = CoHIMatSorted(1:ceil(length(CoHIMatSorted)*UserDefinedPercent/100));

CoHI_capture_Group1 = length(intersect(Group1_CoHI, Group1_Actual)) / length(Group1_Actual);
CoHI_capture_Group2 = length(intersect(Group2_CoHI, Group2_Actual)) / length(Group2_Actual);
CoHI_capture_Group3 = length(intersect(Group3_CoHI, Group3_Actual)) / length(Group3_Actual);
CoHI_capture_Group4 = length(intersect(Group4_CoHI, Group4_Actual)) / length(Group4_Actual);
CoHI_capture_Group5 = length(intersect(Group5_CoHI, Group5_Actual)) / length(Group5_Actual);
CoHI_capture_Group6 = length(intersect(Group6_CoHI, Group6_Actual)) / length(Group6_Actual);
%CoHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_CoHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Modified Connecticut Hazard Rating Formula
%=========================================================================%
Modified_CoHIMat = {};
Modified_CoHIMat(:,1) = CrossingID;
Modified_CoHIMat(:,2) = num2cell(Rank_Modified_CoHI);
Modified_CoHIMatSorted = sortrows(Modified_CoHIMat, 2);
Group1_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)* Crossing_Group1));
Group2_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)* Crossing_Group2));
Group3_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)* Crossing_Group3));
Group4_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)* Crossing_Group4));
Group5_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)* Crossing_Group5));
Group6_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_Modified_CoHI = Modified_CoHIMatSorted(1:ceil(length(Modified_CoHIMatSorted)*UserDefinedPercent/100));

Modified_CoHI_capture_Group1 = length(intersect(Group1_Modified_CoHI, Group1_Actual)) / length(Group1_Actual);
Modified_CoHI_capture_Group2 = length(intersect(Group2_Modified_CoHI, Group2_Actual)) / length(Group2_Actual);
Modified_CoHI_capture_Group3 = length(intersect(Group3_Modified_CoHI, Group3_Actual)) / length(Group3_Actual);
Modified_CoHI_capture_Group4 = length(intersect(Group4_Modified_CoHI, Group4_Actual)) / length(Group4_Actual);
Modified_CoHI_capture_Group5 = length(intersect(Group5_Modified_CoHI, Group5_Actual)) / length(Group5_Actual);
Modified_CoHI_capture_Group6 = length(intersect(Group6_Modified_CoHI, Group6_Actual)) / length(Group6_Actual);
%Modified_CoHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_Modified_CoHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Illinois Hazard Index Formula
%=========================================================================%
IHIMat = {};
IHIMat(:,1) = CrossingID;
IHIMat(:,2) = num2cell(Rank_IHI);
IHIMatSorted = sortrows(IHIMat, 2);
Group1_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)* Crossing_Group1));
Group2_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)* Crossing_Group2));
Group3_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)* Crossing_Group3));
Group4_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)* Crossing_Group4));
Group5_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)* Crossing_Group5));
Group6_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_IHI = IHIMatSorted(1:ceil(length(IHIMatSorted)*UserDefinedPercent/100));

IHI_capture_Group1 = length(intersect(Group1_IHI, Group1_Actual)) / length(Group1_Actual);
IHI_capture_Group2 = length(intersect(Group2_IHI, Group2_Actual)) / length(Group2_Actual);
IHI_capture_Group3 = length(intersect(Group3_IHI, Group3_Actual)) / length(Group3_Actual);
IHI_capture_Group4 = length(intersect(Group4_IHI, Group4_Actual)) / length(Group4_Actual);
IHI_capture_Group5 = length(intersect(Group5_IHI, Group5_Actual)) / length(Group5_Actual);
IHI_capture_Group6 = length(intersect(Group6_IHI, Group6_Actual)) / length(Group6_Actual);
%IHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_IHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Michigan Hazard Index Formula
%=========================================================================%
MHIMat = {};
MHIMat(:,1) = CrossingID;
MHIMat(:,2) = num2cell(Rank_MHI);
MHIMatSorted = sortrows(MHIMat, 2);
Group1_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)* Crossing_Group1));
Group2_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)* Crossing_Group2));
Group3_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)* Crossing_Group3));
Group4_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)* Crossing_Group4));
Group5_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)* Crossing_Group5));
Group6_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_MHI = MHIMatSorted(1:ceil(length(MHIMatSorted)*UserDefinedPercent/100));

MHI_capture_Group1 = length(intersect(Group1_MHI, Group1_Actual)) / length(Group1_Actual);
MHI_capture_Group2 = length(intersect(Group2_MHI, Group2_Actual)) / length(Group2_Actual);
MHI_capture_Group3 = length(intersect(Group3_MHI, Group3_Actual)) / length(Group3_Actual);
MHI_capture_Group4 = length(intersect(Group4_MHI, Group4_Actual)) / length(Group4_Actual);
MHI_capture_Group5 = length(intersect(Group5_MHI, Group5_Actual)) / length(Group5_Actual);
MHI_capture_Group6 = length(intersect(Group6_MHI, Group6_Actual)) / length(Group6_Actual);
%MHI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_MHI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Texas Priority Index Formula
%=========================================================================%
TPIMat = {};
TPIMat(:,1) = CrossingID;
TPIMat(:,2) = num2cell(Rank_TPI);
TPIMatSorted = sortrows(TPIMat, 2);
Group1_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)* Crossing_Group1));
Group2_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)* Crossing_Group2));
Group3_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)* Crossing_Group3));
Group4_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)* Crossing_Group4));
Group5_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)* Crossing_Group5));
Group6_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_TPI = TPIMatSorted(1:ceil(length(TPIMatSorted)*UserDefinedPercent/100));

TPI_capture_Group1 = length(intersect(Group1_TPI, Group1_Actual)) / length(Group1_Actual);
TPI_capture_Group2 = length(intersect(Group2_TPI, Group2_Actual)) / length(Group2_Actual);
TPI_capture_Group3 = length(intersect(Group3_TPI, Group3_Actual)) / length(Group3_Actual);
TPI_capture_Group4 = length(intersect(Group4_TPI, Group4_Actual)) / length(Group4_Actual);
TPI_capture_Group5 = length(intersect(Group5_TPI, Group5_Actual)) / length(Group5_Actual);
TPI_capture_Group6 = length(intersect(Group6_TPI, Group6_Actual)) / length(Group6_Actual);
%TPI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_TPI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Modified Texas Priority Index Formula
%=========================================================================%
Modified_TPIMat = {};
Modified_TPIMat(:,1) = CrossingID;
Modified_TPIMat(:,2) = num2cell(Rank_Modified_TPI);
Modified_TPIMatSorted = sortrows(Modified_TPIMat, 2);
Group1_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)* Crossing_Group1));
Group2_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)* Crossing_Group2));
Group3_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)* Crossing_Group3));
Group4_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)* Crossing_Group4));
Group5_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)* Crossing_Group5));
Group6_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_Modified_TPI = Modified_TPIMatSorted(1:ceil(length(Modified_TPIMatSorted)*UserDefinedPercent/100));

Modified_TPI_capture_Group1 = length(intersect(Group1_Modified_TPI, Group1_Actual)) / length(Group1_Actual);
Modified_TPI_capture_Group2 = length(intersect(Group2_Modified_TPI, Group2_Actual)) / length(Group2_Actual);
Modified_TPI_capture_Group3 = length(intersect(Group3_Modified_TPI, Group3_Actual)) / length(Group3_Actual);
Modified_TPI_capture_Group4 = length(intersect(Group4_Modified_TPI, Group4_Actual)) / length(Group4_Actual);
Modified_TPI_capture_Group5 = length(intersect(Group5_Modified_TPI, Group5_Actual)) / length(Group5_Actual);
Modified_TPI_capture_Group6 = length(intersect(Group6_Modified_TPI, Group6_Actual)) / length(Group6_Actual);
%Modified_TPI_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_Modified_TPI, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Coleman Stewart Model
%=========================================================================%
CSMat = {};
CSMat(:,1) = CrossingID;
CSMat(:,2) = num2cell(Rank_CS);
CSMatSorted = sortrows(CSMat, 2);
Group1_CS = CSMatSorted(1:ceil(length(CSMatSorted)* Crossing_Group1));
Group2_CS = CSMatSorted(1:ceil(length(CSMatSorted)* Crossing_Group2));
Group3_CS = CSMatSorted(1:ceil(length(CSMatSorted)* Crossing_Group3));
Group4_CS = CSMatSorted(1:ceil(length(CSMatSorted)* Crossing_Group4));
Group5_CS = CSMatSorted(1:ceil(length(CSMatSorted)* Crossing_Group5));
Group6_CS = CSMatSorted(1:ceil(length(CSMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_CS = CSMatSorted(1:ceil(length(CSMatSorted)*UserDefinedPercent/100));

CS_capture_Group1 = length(intersect(Group1_CS, Group1_Actual)) / length(Group1_Actual);
CS_capture_Group2 = length(intersect(Group2_CS, Group2_Actual)) / length(Group2_Actual);
CS_capture_Group3 = length(intersect(Group3_CS, Group3_Actual)) / length(Group3_Actual);
CS_capture_Group4 = length(intersect(Group4_CS, Group4_Actual)) / length(Group4_Actual);
CS_capture_Group5 = length(intersect(Group5_CS, Group5_Actual)) / length(Group5_Actual);
CS_capture_Group6 = length(intersect(Group6_CS, Group6_Actual)) / length(Group6_Actual);
%CS_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_CS, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by NCHRP Report 50 Accident Prediction Formula
%=========================================================================%
NCHRPMat = {};
NCHRPMat(:,1) = CrossingID;
NCHRPMat(:,2) = num2cell(Rank_NCHRP);
NCHRPMatSorted = sortrows(NCHRPMat, 2);
Group1_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)* Crossing_Group1));
Group2_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)* Crossing_Group2));
Group3_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)* Crossing_Group3));
Group4_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)* Crossing_Group4));
Group5_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)* Crossing_Group5));
Group6_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_NCHRP = NCHRPMatSorted(1:ceil(length(NCHRPMatSorted)*UserDefinedPercent/100));

NCHRP_capture_Group1 = length(intersect(Group1_NCHRP, Group1_Actual)) / length(Group1_Actual);
NCHRP_capture_Group2 = length(intersect(Group2_NCHRP, Group2_Actual)) / length(Group2_Actual);
NCHRP_capture_Group3 = length(intersect(Group3_NCHRP, Group3_Actual)) / length(Group3_Actual);
NCHRP_capture_Group4 = length(intersect(Group4_NCHRP, Group4_Actual)) / length(Group4_Actual);
NCHRP_capture_Group5 = length(intersect(Group5_NCHRP, Group5_Actual)) / length(Group5_Actual);
NCHRP_capture_Group6 = length(intersect(Group6_NCHRP, Group6_Actual)) / length(Group6_Actual);
%NCHRP_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_NCHRP, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by Peabody Dimmick Formula
%=========================================================================%
PDMat = {};
PDMat(:,1) = CrossingID;
PDMat(:,2) = num2cell(Rank_PD);
PDMatSorted = sortrows(PDMat, 2);
Group1_PD = PDMatSorted(1:ceil(length(PDMatSorted)* Crossing_Group1));
Group2_PD = PDMatSorted(1:ceil(length(PDMatSorted)* Crossing_Group2));
Group3_PD = PDMatSorted(1:ceil(length(PDMatSorted)* Crossing_Group3));
Group4_PD = PDMatSorted(1:ceil(length(PDMatSorted)* Crossing_Group4));
Group5_PD = PDMatSorted(1:ceil(length(PDMatSorted)* Crossing_Group5));
Group6_PD = PDMatSorted(1:ceil(length(PDMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_PD = PDMatSorted(1:ceil(length(PDMatSorted)*UserDefinedPercent/100));

PD_capture_Group1 = length(intersect(Group1_PD, Group1_Actual)) / length(Group1_Actual);
PD_capture_Group2 = length(intersect(Group2_PD, Group2_Actual)) / length(Group2_Actual);
PD_capture_Group3 = length(intersect(Group3_PD, Group3_Actual)) / length(Group3_Actual);
PD_capture_Group4 = length(intersect(Group4_PD, Group4_Actual)) / length(Group4_Actual);
PD_capture_Group5 = length(intersect(Group5_PD, Group5_Actual)) / length(Group5_Actual);
PD_capture_Group6 = length(intersect(Group6_PD, Group6_Actual)) / length(Group6_Actual);
%PD_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_PD, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=========================================================================%
% Percentage of Riskiest Crossings Captured by U.S. DOT Formula
%=========================================================================%
USDOTMat = {};
USDOTMat(:,1) = CrossingID;
USDOTMat(:,2) = num2cell(Rank_USDOT);
USDOTMatSorted = sortrows(USDOTMat, 2);
Group1_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)* Crossing_Group1));
Group2_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)* Crossing_Group2));
Group3_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)* Crossing_Group3));
Group4_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)* Crossing_Group4));
Group5_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)* Crossing_Group5));
Group6_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)* Crossing_Group6));
%Top_User_Defined_Percent_USDOT = USDOTMatSorted(1:ceil(length(USDOTMatSorted)*UserDefinedPercent/100));

USDOT_capture_Group1 = length(intersect(Group1_USDOT, Group1_Actual)) / length(Group1_Actual);
USDOT_capture_Group2 = length(intersect(Group2_USDOT, Group2_Actual)) / length(Group2_Actual);
USDOT_capture_Group3 = length(intersect(Group3_USDOT, Group3_Actual)) / length(Group3_Actual);
USDOT_capture_Group4 = length(intersect(Group4_USDOT, Group4_Actual)) / length(Group4_Actual);
USDOT_capture_Group5 = length(intersect(Group5_USDOT, Group5_Actual)) / length(Group5_Actual);
USDOT_capture_Group6 = length(intersect(Group6_USDOT, Group6_Actual)) / length(Group6_Actual);
%USDOT_capture_User_Defined_Percent = length(intersect(Top_User_Defined_Percent_USDOT, Top_User_Defined_Percent_Actual)) / length(Top_User_Defined_Percent_Actual);

%=====================================================================================================================================================================%

Portion_of_the_Riskiest_Crossings_Captured_from_Group1 = table(NHHI_capture_Group1, CaHI_capture_Group1, Modified_CaHI_capture_Group1, CoHI_capture_Group1, Modified_CoHI_capture_Group1, ...
    IHI_capture_Group1, MHI_capture_Group1, TPI_capture_Group1, Modified_TPI_capture_Group1, CS_capture_Group1, NCHRP_capture_Group1, PD_capture_Group1, USDOT_capture_Group1)

Portion_of_the_Riskiest_Crossings_Captured_from_Group2 = table(NHHI_capture_Group2, CaHI_capture_Group2, Modified_CaHI_capture_Group2, CoHI_capture_Group2, Modified_CoHI_capture_Group2, ...
    IHI_capture_Group2, MHI_capture_Group2, TPI_capture_Group2, Modified_TPI_capture_Group2, CS_capture_Group2, NCHRP_capture_Group2, PD_capture_Group2, USDOT_capture_Group2)

Portion_of_the_Riskiest_Crossings_Captured_from_Group3 = table(NHHI_capture_Group3, CaHI_capture_Group3, Modified_CaHI_capture_Group3, CoHI_capture_Group3, Modified_CoHI_capture_Group3, ...
    IHI_capture_Group3, MHI_capture_Group3, TPI_capture_Group3, Modified_TPI_capture_Group3, CS_capture_Group3, NCHRP_capture_Group3, PD_capture_Group3, USDOT_capture_Group3)

Portion_of_the_Riskiest_Crossings_Captured_from_Group4 = table(NHHI_capture_Group4, CaHI_capture_Group4, Modified_CaHI_capture_Group4, CoHI_capture_Group4, Modified_CoHI_capture_Group4, ...
    IHI_capture_Group4, MHI_capture_Group4, TPI_capture_Group4, Modified_TPI_capture_Group4, CS_capture_Group4, NCHRP_capture_Group4, PD_capture_Group4, USDOT_capture_Group4)

Portion_of_the_Riskiest_Crossings_Captured_from_Group5 = table(NHHI_capture_Group5, CaHI_capture_Group5, Modified_CaHI_capture_Group5, CoHI_capture_Group5, Modified_CoHI_capture_Group5, ...
    IHI_capture_Group5, MHI_capture_Group5, TPI_capture_Group5, Modified_TPI_capture_Group5, CS_capture_Group5, NCHRP_capture_Group5, PD_capture_Group5, USDOT_capture_Group5)

Portion_of_the_Riskiest_Crossings_Captured_from_Group6 = table(NHHI_capture_Group6, CaHI_capture_Group6, Modified_CaHI_capture_Group6, CoHI_capture_Group6, Modified_CoHI_capture_Group6, ...
    IHI_capture_Group6, MHI_capture_Group6, TPI_capture_Group6, Modified_TPI_capture_Group6, CS_capture_Group6, NCHRP_capture_Group6, PD_capture_Group6, USDOT_capture_Group6)

% Portion_of_the_User_Defined_Percent_Riskiest_Crossings_Captured = table(NHHI_capture_User_Defined_Percent, ...
%     CaHI_capture_User_Defined_Percent, Modified_CaHI_capture_User_Defined_Percent, ...
%     CoHI_capture_User_Defined_Percent, Modified_CoHI_capture_User_Defined_Percent, ...
%     IHI_capture_User_Defined_Percent, MHI_capture_User_Defined_Percent, ...
%     TPI_capture_User_Defined_Percent, Modified_TPI_capture_User_Defined_Percent, ...
%     CS_capture_User_Defined_Percent, NCHRP_capture_User_Defined_Percent, ...
%     PD_capture_User_Defined_Percent, USDOT_capture_User_Defined_Percent)


%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spearman’s Rank Correlation Coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%
% Spearman’s Rank Correlation Coefficient for New Hampshire Formula
Spearman_NHHI = 5*sum((Rank_NHHI - mean(Rank_NHHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_NHHI - mean(Rank_NHHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for California Hazard Rating Formula
Spearman_CaHI = 5*sum((Rank_CaHI - mean(Rank_CaHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_CaHI - mean(Rank_CaHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Modified California Hazard Rating Formula
Spearman_Modified_CaHI = 5*sum((Rank_Modified_CaHI - mean(Rank_Modified_CaHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_Modified_CaHI - mean(Rank_Modified_CaHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Connecticut Hazard Rating Formula
Spearman_CoHI = 5*sum((Rank_CoHI - mean(Rank_CoHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_CoHI - mean(Rank_CoHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Modified Connecticut Hazard Rating Formula
Spearman_Modified_CoHI = 5*sum((Rank_Modified_CoHI - mean(Rank_Modified_CoHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_Modified_CoHI - mean(Rank_Modified_CoHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Illinois Hazard Index Formula
Spearman_IHI = 5*sum((Rank_IHI - mean(Rank_IHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_IHI - mean(Rank_IHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Michigan Hazard Index Formula
Spearman_MHI = 5*sum((Rank_MHI - mean(Rank_MHI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_MHI - mean(Rank_MHI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Texas Priority Index Formula
Spearman_TPI = 5*sum((Rank_TPI - mean(Rank_TPI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_TPI - mean(Rank_TPI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Modified Texas Priority Index Formula
Spearman_Modified_TPI = 5*sum((Rank_Modified_TPI - mean(Rank_Modified_TPI)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_Modified_TPI - mean(Rank_Modified_TPI)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Coleman Stewart Model
Spearman_CS = 5*sum((Rank_CS - mean(Rank_CS)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_CS - mean(Rank_CS)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for NCHRP Report 50 Accident Prediction Formula
Spearman_NCHRP = 5*sum((Rank_NCHRP - mean(Rank_NCHRP)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_NCHRP - mean(Rank_NCHRP)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for Peabody Dimmick Formula
Spearman_PD = 5*sum((Rank_PD - mean(Rank_PD)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_PD - mean(Rank_PD)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

% Spearman’s Rank Correlation Coefficient for U.S. DOT Formula
Spearman_USDOT = 5*sum((Rank_USDOT - mean(Rank_USDOT)) .* (Rank_Actual - mean(Rank_Actual))) ./ sqrt(sum((Rank_USDOT - mean(Rank_USDOT)).^2) .* sum((Rank_Actual - mean(Rank_Actual)).^2));

%======================================================================================================================================================================================================================================================================%

Spearmans_Rank_Correlation_Coefficient = table(Spearman_NHHI, Spearman_CaHI, Spearman_Modified_CaHI, Spearman_CoHI, Spearman_Modified_CoHI, Spearman_IHI, Spearman_MHI, Spearman_TPI, Spearman_Modified_TPI, Spearman_CS, Spearman_NCHRP, Spearman_PD, Spearman_USDOT)

%=========================================================================%
 
