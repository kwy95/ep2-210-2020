% Nomes: Cainã Setti Galante                             Nº USP: 10737115
%        Rubens Gomes Neto                                        9318484
%
% Arquivo parte do EP2 de MAC0210

function err = calculateError(originalImg, decompressedImg)
    A = double(imread(originalImg));
    B = double(imread(decompressedImg));


    origR = A(:, :, 1);
    origG = A(:, :, 2);
    origB = A(:, :, 3);

    decR = B(:, :, 1);
    decG = B(:, :, 2);
    decB = B(:, :, 3);

    errR = norm(origR - decR)/norm(origR);
    errG = norm(origG - decG)/norm(origG);
    errB = norm(origB - decB)/norm(origB);

    err = (errR + errG + errB)/3;
    err
endfunction
