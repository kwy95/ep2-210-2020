function B = expand(A, k)
    [m, n, _] = size(A);

    ph = m + (m-1)*k;
    pw = n + (n-1)*k;
    x = 1:k+1:pw;
    y = 1:k+1:ph;
    %for y = 1:k+1:ph
        %for x = 1:k+1:pw
    B(y , x, :) = A(((y - 1) ./ (k + 1)) + 1, ((x - 1) ./ (k + 1)) + 1, :);
        %endfor
    %endfor
endfunction
