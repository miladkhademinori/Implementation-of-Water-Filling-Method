function    Landa = landa_Calculator ( R_Min_Dynamic , K_Star_FullPower , K_Star_Negative , H_Sorted )
    numerator = (2^R_Min_Dynamic)^ (1/(K_Star_Negative - K_Star_FullPower - 1));
    denominator = H_Sorted(1 , (K_Star_FullPower + 1):(K_Star_Negative - 1)) .^ (1/(K_Star_Negative - K_Star_FullPower - 1)) ;
    Landa = numerator /(prod(denominator));
end