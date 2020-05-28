function B = expand(A, k)
    [m, n, _] = size(A);

    ph = m + (m-1)*k;
    pw = n + (n-1)*k;

    for y = 1:ph
        for x = 1:pw
            if (rem(y, k+1) == 1 && rem(x, k+1) == 1)
                B(y , x, :) = A(((y - 1) / (k + 1)) + 1, ((x - 1) / (k + 1)) + 1, :);
            endif
        endfor
    endfor
endfunction
