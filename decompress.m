% Nomes: Cainã Setti Galante                             Nº USP: 10737115
%        Rubens Gomes Neto                                        9318484
%
% Arquivo parte do EP2 de MAC0210

% Recebe uma imagem comprimida e a descomprime usando o método bilinear ou o  método bicúbico.
% A taxa de descompressão é dada pelo k e o h representa o tamanho do lado utilizado para o
% método escolhido para a interpolação.
function decompress(compressedImg, method, k, h = k+1)
    C   = imread(compressedImg);
    C_e = expand(C, k);
    if (method == 1) % bilinear
        D = bilinear(C_e, k, h);
        imwrite(D, 'decompressed.png', 'Compression', 'none');
    elseif (method == 2) % bicubico
        D = bicubico(C_e, k, h);
        imwrite(D, 'decompressed.png', 'Compression', 'none');
    endif
    % imwrite(C_e, 'expanded.png', 'Compression', 'none');
endfunction


% Expande a matrix A m por n para uma m + (m-1)*k por n + (n-1)*k
function B = expand(A, k)
    [m, n, _] = size(A);

    ph = m + (m-1)*k;
    pw = n + (n-1)*k;

    x = 1:k+1:pw;
    y = 1:k+1:ph;

    B(y , x, :) = A(((y - 1) / (k + 1)) + 1, ((x - 1) / (k + 1)) + 1, :);
endfunction

function C = bilinear(img, k, h)
    C = img;
    [ph, pw, rgb] = size(img);
    D = [1, 0, 0, 0;
         1, 0, h, 0;
         1, h, 0, 0;
         1, h, h, h.^2];
    % Para cada quadrado
    for i = 1:k+1:ph-(k+1)
        for j = 1:k+1:pw-(k+1)
            fx1y1 = C(i, j, :);
            fx1y2 = C(i, j+(k+1), :);
            fx2y1 = C(i+(k+1), j, :);
            fx2y2 = C(i+(k+1), j+(k+1), :);
            for l = 1:rgb
                E = [fx1y1(l); fx1y2(l); fx2y1(l); fx2y2(l)];
                F = double(E);
                X = D\F;
                for m = i:i+k+1
                    for n = j:j+k+1
                        if ((m != i || n != j) && (m != i || n != j+(k+1)) && (m != i+(k+1) || n != j) && (m != i+(k+1) || n != j+(k+1)))
                            x = ((m-i)/(k+1))*h;
                            y = ((n-j)/(k+1))*h;
                            C(m, n, l) = X(1) + X(2).*x + X(3).*y + X(4).*x.*y;
                        endif
                    endfor
                endfor
            endfor
        endfor
    endfor
endfunction

% derivadas como definidas no enunciado, com casos especiais para os extremos
function D = derivax (i, j, k, h, ph, pw, F)
    if (j <= 1)
        D = (F(i, 1+(k+1), :) - F(i, 1, :)) ./ h;
    elseif (j >= pw-(k+1))
        D = (F(i, (pw-(k+1)), :) - F(i, (pw-(k+1))-(k+1), :)) ./ h;
    else
        D = (F(i, j+(k+1), :) - F(i, j-(k+1), :)) ./ (2.*h);
    endif
endfunction

function D = derivay (i, j, k, h, ph, pw, F)
    if (i <= 1)
        D = (F(1+(k+1), j, :) - F(1, j, :)) ./ h;
    elseif (i >= ph-(k+1))
        D = (F((ph-(k+1)), j, :) - F((ph-(k+1))-(k+1), j, :)) ./ h;
    else
        D = (F(i+(k+1), j, :) - F(i-(k+1), j, :)) ./ (2.*h);
    endif
endfunction

function D = derivaxy (i, j, k, h, ph, pw, F)
    if (j <= 1)
        D = (derivay(i, j+(k+1), k, h, ph, pw, F) - derivay(i, j, k, h, ph, pw, F)) ./ h;
    elseif (j >= ph-(k+1))
        D = (derivay(i, j, k, h, ph, pw, F) - derivay(i, j-(k+1), k, h, ph, pw, F)) ./ h;
    else
        D = (derivay(i, j+(k+1), k, h, ph, pw, F) - derivay(i, j-(k+1), k, h, ph, pw, F)) ./ (2.*h);
    endif
endfunction

function B = bicubico (A, k, h)
    B = A;
    [ph, pw, rgb] = size(B);
    % No enunciado essa é a matriz B
    C = [1, 0, 0,    0;
         1, h, h.*h, h.*h.*h;
         0, 1, 0,    0;
         0, 1, 2.*h, 3.*h.*h];
    % Para cada quadrado.
    for i = 1:k+1:ph-(k+1)
        for j = 1:k+1:pw-(k+1)
            fx1y1 = B(i, j, :);
            fx1y2 = B(i+(k+1), j, :);
            fx2y1 = B(i, j+(k+1), :);
            fx2y2 = B(i+(k+1), j+(k+1), :);
            dyfx1y1 = derivay(i, j, k, h, ph, pw, B);
            dyfx1y2 = derivay(i+(k+1), j, k, h, ph, pw, B);
            dyfx2y1 = derivay(i, j+(k+1), k, h, ph, pw, B);
            dyfx2y2 = derivay(i+(k+1), j+(k+1), k, h, ph, pw, B);
            dxfx1y1 = derivax(i, j, k, h, ph, pw, B);
            dxfx1y2 = derivax(i+(k+1), j, k, h, ph, pw, B);
            dxfx2y1 = derivax(i, j+(k+1), k, h, ph, pw, B);
            dxfx2y2 = derivax(i+(k+1), j+(k+1), k, h, ph, pw, B);
            dxyfx1y1 = derivaxy(i, j, k, h, ph, pw, B);
            dxyfx1y2 = derivaxy(i+(k+1), j, k, h, ph, pw, B);
            dxyfx2y1 = derivaxy(i, j+(k+1), k, h, ph, pw, B);
            dxyfx2y2 = derivaxy(i+(k+1), j+(k+1), k, h, ph, pw, B);
            for l = 1:rgb
                D =   [  fx1y1(l),   fx1y2(l),  dyfx1y1(l),  dyfx1y2(l);
                         fx2y1(l),   fx2y2(l),  dyfx2y1(l),  dyfx2y2(l);
                       dxfx1y1(l), dxfx1y2(l), dxyfx1y1(l), dxyfx1y2(l);
                       dxfx2y1(l), dxfx2y2(l), dxyfx2y1(l), dxyfx2y2(l)];
                E = double(D);
                % Matriz de coeficientes do polinomio intepolador
                X = (C\E)*inverse(C');
                % Para cada pixel dentro desse quadrado.
                for m = i:i+(k+1)
                    for n = j:j+(k+1)
                        % Se não for o pixel original usado para a interpolação.
                        if ((m != i || n != j) && (m != i || n != j+(k+1)) && (m != i+(k+1) || n != j) && (m != i+(k+1) || n != j+(k+1)))
                            x = ((n-j)/(k+1))*h;
                            y = ((m-i)/(k+1))*h;
                            B(m, n, l) = [1, x, x.^2, x.^3]*X*[1; y; y.^2; y.^3];
                        endif
                    endfor
                endfor
            endfor
        endfor
    endfor
endfunction
