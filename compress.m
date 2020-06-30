% Nomes: Cainã Setti Galante                             Nº USP: 10737115
%        Rubens Gomes Neto                                        9318484
%
% Arquivo parte do EP2 de MAC0210

function compress (originalImg, k, output = 'compressed.png')
    img = imread(originalImg);
    [ph, pw, _] = size(img);

    img = img(1:k+1:ph, 1:k+1:pw, :);
    imwrite(img, output, 'Compression', 'none');
endfunction
