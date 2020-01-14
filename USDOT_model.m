%=========================================================================%
%U.S. DOT Accident Prediction Formula (source: Qureshi et al., 2003; U.S. DOT, 2007; Chadwick et al., 2014; Ryan and Mielke, 2017)
%==========================================================================
function [USDOT_a, USDOT_B, USDOT_final, NC_PSV, NC_FLS, NC_GTS] = USDOT_model(Protection, V, T, MainTrk, d, hp, ms, ht, nl, ObservedAcc, AwdIDate, AH2016, AH2015, AH2014, AH2013, AH5_USDOT)
%=========================================================================%
USDOTmat = cell(length(Protection),18);
%=========================================================================%

USDOTmat (:,1) = Protection; USDOTmat (:,2) = num2cell(V); 
USDOTmat (:,3) = num2cell(T); USDOTmat (:,4) = num2cell(MainTrk); USDOTmat (:,5) = num2cell(d);
USDOTmat (:,6) = num2cell(hp); USDOTmat (:,7) = num2cell(ms); USDOTmat (:,8) = num2cell(ht);
USDOTmat (:,9) = num2cell(nl);


for j = 1: length(USDOTmat(:,1))

%=========================================================================%
%Formula constant K
%=========================================================================%
    %Gates    
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
        USDOTmat(j,10) = {0.001088};    
    
    %Flashing lights  
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
        USDOTmat(j,10) = {0.003646};    

    %Other types of protection (including passive warning devices)
    else
        USDOTmat(j,10) = {0.002268};
       
    end;

%=========================================================================%
%Exposure Index Factor EI
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01'))) 
        USDOTmat(j,11) = {((cell2mat(USDOTmat(j,2)) .* cell2mat(USDOTmat(j,3))+ 0.2)/0.2)^0.3116};    

    %Flashing lights   
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
        USDOTmat(j,11) = {((cell2mat(USDOTmat(j,2)) .* cell2mat(USDOTmat(j,3))+ 0.2)/0.2)^0.2953};

    %Other types of protection (including passive warning devices)
    else
        USDOTmat(j,11) = {((cell2mat(USDOTmat(j,2)) .* cell2mat(USDOTmat(j,3))+ 0.2)/0.2)^0.3334};
         
    end;

%=========================================================================%
%Main Tracks Factor MT
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
       USDOTmat(j,12) = {exp(0.2912 .* cell2mat(USDOTmat(j,4)))};
      
    %Flashing lights   
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
       USDOTmat(j,12) = {exp(0.1088 .* cell2mat(USDOTmat(j,4)))};
        
    %Other types of protection (including passive warning devices)   
    else
       USDOTmat(j,12) = {exp(0.2094 .* cell2mat(USDOTmat(j,4)))}; 
         
    end;
    
%=========================================================================%
%Day Thru Trains Factor DT
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
       USDOTmat(j,13) = {1};    

    %Flashing lights   
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
        if isempty(USDOTmat(j,5)) % If no data regarding the number of through trains per day is available, use DT = 1;
            USDOTmat(j,13) = {1};
        else
            USDOTmat(j,13) = {((cell2mat(USDOTmat(j,5)) + 0.2)/0.2)^0.0470};
        end;
        
    %Other types of protection (including passive warning devices)
    else
        if isempty(USDOTmat(j,5)) % If no data regarding the number of through trains per day is available, use DT = 1;
            USDOTmat(j,13) = {1};
        else
            USDOTmat(j,13) = {((cell2mat(USDOTmat(j,5)) + 0.2)/0.2)^0.1336};
        end;
       
    end;
    
%=========================================================================%
%Highway Paved Factor HP
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
       USDOTmat(j,14) = {1};

    %Flashing lights
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
       USDOTmat(j,14) = {1}; 
       
    %Other types of protection (including passive warning devices)     
    else
        if isempty(USDOTmat(j,6)) % If no data regarding highway pavement is available, use HP = 1;
            USDOTmat(j,14) = {1};
        else
            USDOTmat(j,14) = {exp(-0.6160.* (cell2mat(USDOTmat(j,6))-1))};
        end;
        
    end;
    
%=========================================================================%
%Maximum Speed Factor MS
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
       USDOTmat(j,15) = {1};    
    
    %Flashing lights   
   elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
       USDOTmat(j,15) = {1};

    %Other types of protection (including passive warning devices)
    else
        if isempty(USDOTmat(j,7)) % If no data regarding the maximum timetable speed is available, use MS = 1;
            USDOTmat(j,15) = {1};
        else
            USDOTmat(j,15) = {exp(0.0077.* cell2mat(USDOTmat(j,7)))};
        end;
        
    end;
    
%=========================================================================%
%Highway Type Factor HT
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
       USDOTmat(j,16) = {1};

    %Flashing lights
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
       USDOTmat(j,16) = {1};

    %Other types of protection (including passive warning devices)    
    else
        if isempty(USDOTmat(j,8)) % If no data regarding highway type is available, use HT = 1;
            USDOTmat(j,16) = {1};
        else
            USDOTmat(j,16) = {exp(-0.1000.* (cell2mat(USDOTmat(j,8))-1))};
        end;
    
    end;
    
%=========================================================================%
%Highway Lanes Factor HL
%=========================================================================%
    %Gates
    if ~isempty(cell2mat(strfind(USDOTmat(j,1), '01')))
        if isempty(USDOTmat(j,9)) % If no data regarding the number of traffic lanes is available, use HL = 1;
            USDOTmat(j,17) = {1};
        else
            USDOTmat(j,17) = {exp(0.1036.*(cell2mat(USDOTmat(j,9))-1))};
        end;
        
    %Flashing lights
    elseif ~isempty(cell2mat(strfind(USDOTmat(j,1), '02'))) || ~isempty(cell2mat(strfind(USDOTmat(j,1), '03')))
        if isempty(USDOTmat(j,9)) % If no data regarding the number of traffic lanes is available, use HL = 1;
            USDOTmat(j,17) = {1};
        else
            USDOTmat(j,17) = {exp(0.1380.*(cell2mat(USDOTmat(j,9))-1))};
        end;
        
    %Other types of protection (including passive warning devices)   
    else
       USDOTmat(j,17) = {1};
  
    end;
    
%=========================================================================%
 
end
    

K = cell2mat(USDOTmat(:,10)); EI = cell2mat(USDOTmat(:,11)); MT = cell2mat(USDOTmat(:,12));
DT = cell2mat(USDOTmat(:,13)); HP = cell2mat(USDOTmat(:,14)); MS = cell2mat(USDOTmat(:,15));
HT = cell2mat(USDOTmat(:,16)); HL = cell2mat(USDOTmat(:,17));

USDOT_a = K .* EI .* MT .* DT .* HP .* MS .* HT .* HL;

T0 = 1./(0.05 + USDOT_a);

AH_USDOT = AH5_USDOT;
T_years = 5 .* ones(length(AH_USDOT),1);

for j = 1: length(AwdIDate);
    
    %If an upgrade was made in 2012, consider 2016-2013 accident data only.
    if ~isempty(cell2mat(strfind(AwdIDate(j), '2012')))
        T_years(j) = 4;
        AH_USDOT(j) = AH2013(j);
    
    %If an upgrade was made in 2013, consider 2016-2014 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2013')))
        T_years(j) = 3;
        AH_USDOT(j) = AH2014(j);
    
    %If an upgrade was made in 2014, consider 2016-2015 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2014')))
        T_years(j) = 2;
        AH_USDOT(j) = AH2015(j);
    
    %If an upgrade was made in 2015, consider 2016 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2015')))
        T_years(j) = 1;
        AH_USDOT(j) = AH2016(j);
    
    %If an upgrade was made in 2016, consider the number of accidents to be zero. The number of years should also be zero.   
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2016')))
        T_years(j) = 1; %This is modified from 0 to 1, so that the denominator of USDOT_B does not become 0.
        AH_USDOT(j) = 0;
        
    else T_years(j) = 5;
        AH_USDOT(j) = AH5_USDOT(j);
        
    end
    
end

USDOT_B  = (T0./(T0 + T_years)) .* USDOT_a + (T0./(T0 + T_years)) .* (AH_USDOT./T_years); % Number of accidents predicted for the year 2017 (using 2012-2016 data)

%=========================================================================%
%%%%%%%%%%%%%%%%%%%%%%%%%% Normalizing Constant %%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%
% Calculation of USDOT_B_Old for the normalizing constants

AH_USDOT_Old = AH5_USDOT;
T_years_Old = 5 .* ones(length(AH_USDOT_Old),1);

for j = 1: length(AwdIDate);
    
    %If an upgrade was made in 2012, consider 2016-2013 accident data only.
    if ~isempty(cell2mat(strfind(AwdIDate(j), '2012')))
        T_years_Old(j) = 4;
        AH_USDOT_Old(j) = AH2013(j);
    
    %If an upgrade was made in 2013, consider 2016-2014 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2013')))
        T_years_Old(j) = 3;
        AH_USDOT_Old(j) = AH2014(j);
    
    %If an upgrade was made in 2014, consider 2016-2015 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2014')))
        T_years_Old(j) = 2;
        AH_USDOT_Old(j) = AH2015(j);
    
    %If an upgrade was made in 2015, consider 2016 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2015')))
        T_years_Old(j) = 1;
        AH_USDOT_Old(j) = AH2016(j);
    
    %If an upgrade was made in 2016, consider the number of accidents to be zero. The number of years should also be zero.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2016')))
        T_years_Old(j) = 1; %This is modified from 0 to 1, so that the denominator of USDOT_B_Old does not become 0.
        AH_USDOT_Old(j) = 0;
        
    else T_years_Old(j) = 5;
        AH_USDOT_Old(j) = AH5_USDOT(j);
        
    end
    
end

USDOT_B_Old  = (T0./(T0 + T_years_Old)) .* USDOT_a + (T0./(T0 + T_years_Old)) .* (AH_USDOT_Old./T_years_Old); % Number of accidents predicted for the year 2017 (using 2012-2016 data)

%=========================================================================%
% Gates
%=========================================================================%
GTSmat_Old = cell(length(Protection),3);
GTSmat_Old (:,1) = Protection;

for j = 1: length(GTSmat_Old(:,1));

    if ~isempty(cell2mat(strfind(GTSmat_Old(j,1), '01')))
        GTSmat_Old(j,2)={USDOT_B_Old(j)};
        GTSmat_Old(j,3)={ObservedAcc(j)};
          
    else GTSmat_Old(j,2)={0};
         GTSmat_Old(j,3)={0};
       
    end;
    
end

Predicted_GTS_Old = cell2mat(GTSmat_Old(:,2));
Observed_GTS = cell2mat(GTSmat_Old(:,3));

NC_GTS = sum(Observed_GTS) / sum(Predicted_GTS_Old);

%=========================================================================%
% Flashing lights
%=========================================================================%
FLSmat_Old = cell(length(Protection),3);
FLSmat_Old (:,1) = Protection;

for j = 1: length(FLSmat_Old(:,1));

    if ~isempty(cell2mat(strfind(FLSmat_Old(j,1), '02'))) || ~isempty(cell2mat(strfind(FLSmat_Old(j,1), '03')))
        FLSmat_Old(j,2)={USDOT_B_Old(j)};
        FLSmat_Old(j,3)={ObservedAcc(j)};
           
    else FLSmat_Old(j,2)={0};
         FLSmat_Old(j,3)={0};
       
    end;
    
end

Predicted_FLS_Old = cell2mat(FLSmat_Old(:,2));
Observed_FLS = cell2mat(FLSmat_Old(:,3));

NC_FLS = sum(Observed_FLS) / sum(Predicted_FLS_Old);

%=========================================================================%
% Passive warning devices AND other types of protection
%=========================================================================%
PSVmat_Old = cell(length(Protection),3);
PSVmat_Old (:,1) = Protection;

for j = 1: length(PSVmat_Old(:,1));

    if isempty(cell2mat(strfind(PSVmat_Old(j,1), '01'))) && isempty(cell2mat(strfind(PSVmat_Old(j,1), '02'))) && isempty(cell2mat(strfind(PSVmat_Old(j,1), '03')))
        PSVmat_Old(j,2)={USDOT_B_Old(j)};
        PSVmat_Old(j,3)={ObservedAcc(j)};
           
    else PSVmat_Old(j,2)={0};
         PSVmat_Old(j,3)={0};
       
    end;
    
end

Predicted_PSV_Old = cell2mat(PSVmat_Old(:,2));
Observed_PSV = cell2mat(PSVmat_Old(:,3));

NC_PSV = sum(Observed_PSV) / sum(Predicted_PSV_Old);

%=========================================================================%
%%%%%%%%%%%%%%%%%%%% Final Accident Prediction %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=========================================================================%
% Predicted number of accidents for different kinds of protection
%=========================================================================%
% Gates
%=========================================================================%
GTSmat = cell(length(Protection),2);
GTSmat (:,1) = Protection;

for j = 1: length(GTSmat(:,1));

    if ~isempty(cell2mat(strfind(GTSmat(j,1), '01')))
        GTSmat(j,2)={USDOT_B(j)};
          
    else GTSmat(j,2)={0};
       
    end;
    
end

Predicted_GTS = cell2mat(GTSmat(:,2));

%=========================================================================%
% Flashing lights
%=========================================================================%
FLSmat = cell(length(Protection),2);
FLSmat (:,1) = Protection;

for j = 1: length(FLSmat(:,1));

    if ~isempty(cell2mat(strfind(FLSmat(j,1), '02'))) || ~isempty(cell2mat(strfind(FLSmat(j,1), '03')))
        FLSmat(j,2)={USDOT_B(j)};
           
    else FLSmat(j,2)={0};
       
    end;
    
end

Predicted_FLS = cell2mat(FLSmat(:,2));

%=========================================================================%
% Passive warning devices AND other types of protection
%=========================================================================%
PSVmat = cell(length(Protection),2);
PSVmat (:,1) = Protection;

for j = 1: length(PSVmat(:,1));

    if isempty(cell2mat(strfind(PSVmat(j,1), '01'))) && isempty(cell2mat(strfind(PSVmat(j,1), '02'))) && isempty(cell2mat(strfind(PSVmat(j,1), '03')))
        PSVmat(j,2)={USDOT_B(j)};
           
    else PSVmat(j,2)={0};
       
    end;
    
end

Predicted_PSV = cell2mat(PSVmat(:,2));

%=========================================================================%
USDOT_final = (Predicted_PSV .* NC_PSV) + (Predicted_FLS .* NC_FLS) + (Predicted_GTS .* NC_GTS); % Final accident predicion for the year 2017