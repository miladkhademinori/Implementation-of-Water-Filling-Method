function P = P_Update_Function_Part2 ( K_Star_FullPower , K_Star_Negative , H_Sorted , Landa , P_Max , Channel_Num )
P = ones (1 , Channel_Num );
for i =  1 : length(P)
    if i <= K_Star_FullPower
        P(1,i) = P_Max;
    elseif K_Star_FullPower < i && i < K_Star_Negative
        P(1,i) = Landa- (1/H_Sorted(1,i));
    else
        P(1,i) = 0;
    end
end
end