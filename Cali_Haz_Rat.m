%=========================================================================%
%California Hazard Rating Formula (source: Elzohairy and Benekohal, 2000; Qureshi et al., 2003)
%==========================================================================
function [CaHI] = Cali_Haz_Rat(Protection, V, T, AH10)
%=========================================================================%
PFmat = cell(length(Protection),2);
%=========================================================================%

PFmat (:,1) = Protection;


for j = 1: length(PFmat)
    
    %If gates are installed at a highway-rail grade crossing, use PF = 0.13;
    if ~isempty(cell2mat(strfind(PFmat(j,1), '01')))
        PFmat(j,2)= {0.13};
        
    %If flashing lights are installed at a highway-rail grade crossing, use PF = 0.33;
    elseif ~isempty(cell2mat(strfind(PFmat(j,1), '03'))) || ~isempty(cell2mat(strfind(PFmat(j,1), '02')))
        PFmat(j,2)={0.33};
        
    %If wig wags are installed at a highway-rail grade crossing, use PF = 0.67;    
    elseif ~isempty(cell2mat(strfind(PFmat(j,1), '04')))
        PFmat(j,2)={0.67};
            
    %Else use the highest value PF = 1.0 (which is adopted for stop signs and crossbucks in the canonical California Hazard Rating Formula);     
    else PFmat(j,2)={1};
         
    end;    
   
end

PF = cell2mat(PFmat(:,2));

AH10_CaHI = AH10;

CaHI = ((V .* T .* PF)/1000) + (AH10_CaHI .*3);
%=========================================================================%
