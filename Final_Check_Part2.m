function [ continue_Flag , K_Star_FullPower , K_Star_Negative , P_Max_Total_Dynamic , P  ] = Final_Check_Part2 ( P_Max_Total_Dynamic , K_Star_FullPower , K_Star_Negative , P_Max , P )
continue_Flag = 0;
Agar_Tanane_max_dashtim_Flag = 0;
for i = 1 : length(P)
    if P ( 1 , i ) > P_Max
        if P_Max_Total_Dynamic > 0
            P_Max_Total_Dynamic = P_Max_Total_Dynamic -  P_Max ;
            K_Star_FullPower = i; 
            Agar_Tanane_max_dashtim_Flag = 1;
        else
            P ( 1 , i ) = 0;
        end

    elseif P ( 1 , i ) == P_Max
        continue;
    elseif P ( 1 , i ) < P_Max && P ( 1 , i ) >= 0
        continue;
    else
        if (K_Star_Negative > i && Agar_Tanane_max_dashtim_Flag == 0)
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