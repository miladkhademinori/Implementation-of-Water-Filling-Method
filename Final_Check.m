function [ continue_Flag , K_Star_FullPower , K_Star_Negative , R_Min_Dynamic ] = Final_Check ( P , R_Min_Dynamic , K_Star_FullPower , K_Star_Negative , P_Max , H_Sorted )
continue_Flag = 0;
Foot_Koozegari_Flag = 0;
for i = 1 : length(P)
    if P ( 1 , i ) > P_Max
        K_Star_FullPower = i;
        R_Min_Dynamic = R_Min_Dynamic - log2( 1 + H_Sorted( 1 , i ) * P_Max );
        Foot_Koozegari_Flag = 1;
    elseif P ( 1 , i ) == P_Max
        continue;
    elseif P ( 1 , i ) < P_Max && P ( 1 , i ) >= 0
        continue;
    else
        if K_Star_Negative > i && Foot_Koozegari_Flag == 0
            K_Star_Negative = i;
        end
    end
end
for i = 1 : length(P)
    if  P ( 1 , i ) > P_Max || P ( 1 , i ) < 0
        continue_Flag = 1;
    end
end


end