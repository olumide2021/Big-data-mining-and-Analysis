%=========================================================================%
%Modified Connecticut Hazard Rating Formula (source: Elzohairy and Benekohal, 2000; Qureshi et al., 2003)
%==========================================================================
function [Modified_CoHI] = Modified_Connect_Haz_Rat(Protection, V, T, AH5, AwdIDate, AH2016, AH2015, AH2014, AH2013)
%=========================================================================%
PFmat = cell(length(Protection),2);
%=========================================================================%

PFmat (:,1) = Protection;


for j = 1: length(PFmat)
    
    %If gates with railroad flashing lights are installed at a highway-rail grade crossing, use PF = 0.01;
    if ~isempty(cell2mat(strfind(PFmat(j,1), '01'))) && (~isempty(cell2mat(strfind(PFmat(j,1), '02'))) || ~isempty(cell2mat(strfind(PFmat(j,1), '03'))))
        PFmat(j,2)={0.01};
        
    %If railroad flashing lights are installed at a highway-rail grade crossing, use PF = 0.25;    
    elseif ~isempty(cell2mat(strfind(PFmat(j,1), '02'))) || ~isempty(cell2mat(strfind(PFmat(j,1), '03')))
        PFmat(j,2)={0.25};
        
    %If manually activated traffic signals are installed at a highway-rail grade crossing, use PF = 0.75;    
    elseif ~isempty(cell2mat(strfind(PFmat(j,1), '05')))
        PFmat(j,2)={0.75};
        
    %If stop sign control is installed at a highway-rail grade crossing, use PF = 1.0;    
    elseif ~isempty(cell2mat(strfind(PFmat(j,1), '08')))
        PFmat(j,2)={1.0};
  
    %Else use the highest value PF = 1.25 (which is adopted for passive warning devices in the canonical Connecticut Hazard Rating Formula);    
    else PFmat(j,2)={1.25};
         
    end;
  
end


PF = cell2mat(PFmat(:,2));

AH5_CoHI = AH5;
   
for j = 1: length(AwdIDate);
    
    %If an upgrade was made in 2012, consider 2016-2013 accident data only.
    if ~isempty(cell2mat(strfind(AwdIDate(j), '2012')))
        AH5_CoHI(j) = AH2013(j);
        
    %If an upgrade was made in 2013, consider 2016-2014 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2013')))
        AH5_CoHI(j) = AH2014(j);
        
    %If an upgrade was made in 2014, consider 2016-2015 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2014')))
        AH5_CoHI(j) = AH2015(j);
        
    %If an upgrade was made in 2015, consider 2016 accident data only.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2015')))
        AH5_CoHI(j) = AH2016(j);
        
    %If an upgrade was made in 2016, consider the number of accidents to be zero.    
    elseif ~isempty(cell2mat(strfind(AwdIDate(j), '2016')))
        AH5_CoHI(j) = 0;
        
    else AH5_CoHI(j) = AH5(j);
        
    end
    
end
   
   
Modified_CoHI = ((T + 1) .* (AH5_CoHI + 1) .* V .* PF)/100;
%=========================================================================%
