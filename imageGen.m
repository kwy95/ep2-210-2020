function imageGen(output, pixels = 281, func = 0)
    A = zeros(pixels, pixels, 3);
    for x = 1:pixels
        for y = 1:pixels
            [r, g, b] = third(x * 2 * pi / pixels, y * 2 * pi / pixels);
            A(y, x, :) = [r, g, b];
        endfor
    endfor
    imwrite(A, output, 'Compression', 'none');
endfunction

function [r, g, b] = first(x, y)
    r = (1 + sin(x)) ./ 2;
    g = (1 + (sin(y) - sin(x)) ./ 2) ./ 2;
    b = (1 + sin(x)) ./ 2;
endfunction

function [r, g, b] = second(x, y)
    r = (1 + cos(x)) ./ 2;
    g = (1 + (sin(y) - sin(x)) ./ 2) ./ 2;
    b = (1 + sin(y)) ./ 2;
endfunction

function [r, g, b] = third(x, y)
    r = (1 + sin(y)) ./ 2;
    g = (1 + (sin(y) - sin(x)) ./ 2) ./ 2;
    b = 0;
    if x > pi
        b = 1;
    endif
endfunction
