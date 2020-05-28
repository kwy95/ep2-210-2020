% Nomes: Cainã Setti Galante                             Nº USP: 10737115
%        Rubens Gomes Neto                                        9318484
%
% Arquivo parte do EP2 de MAC0210

function compress (originalImg, k)
    img = imread(originalImg);
    [ph, pw, rgb] = size(img);

    img = img(1:(k+1):ph, 1:(k+1):pw, :);
    imwrite(img, 'compressed.png');
endfunction
