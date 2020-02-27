%%%% Main file %%%%
%%%%%% Please keep this file and the 'GetAlphabet.m' file in the same
%%%%%% folder along with the image. Please run this file. %%%%%%%%%%%%

clc;
clear all
img= imread('simpsons_frame.png'); % Read input image

imshow(img)                        % Display input image 

alphabets=GetAlphabet(img);        % Calling the function file "GetAlphabet.m"
figure; imshow(alphabets)          % Display final result