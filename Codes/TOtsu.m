function [T] = TOtso(H,total)
sum = 0;
for i = 1:256
    sum = sum + (i * H(i));
end
sumB = 0;
wB = 0;
wF = 0;
mB = 0;
mF = 0;
max = 0;
between = 0;
threshold1 = 0;
threshold2 = 0;
for i = 1:256
    wB = wB + H(i);
    if (wB == 0)
        continue;
    end
    wF = total - wB;
    if (wF == 0)
        break;
    end
    sumB = sumB + (i * H(i));
    mB = sumB / wB;
    mF = (sum - sumB) / wF;
    between = wB * wF * (mB - mF)^2;
    if ( between >= max )
        threshold1 = i;
        if ( between > max )
            threshold2 = i;
        end
        max = between;
    end
end
T = ( threshold1 + threshold2 ) / 2;


