%%%% Function file %%%%%

function AlphabetImage = GetAlphabet(image)
OriginalImage=image; 

NumberOfConnectedPixels= 1000;                                               % Set threshold for blocking out small objects 
StructuringElement=strel('disk',3);                                          % Set size of structuring element for morphological operations
IncreaseTo=3;                                                                % It is observed that some of the parts of the alphabets is not the minimum value in the image. 

MinValue1=min(min(OriginalImage(:,:,1)));                                    % Find minimum value in the R band of image 
MinValue2=min(min(OriginalImage(:,:,2)));                                    % Find minimum value in the G band of image
MinValue3=min(min(OriginalImage(:,:,3)));                                    % Find minimum value in the B band of image

MinValue1=MinValue1+((IncreaseTo));                                          % Set new minimum value
MinValue2=MinValue2+((IncreaseTo));                                          % Set new minimum value
MinValue3=MinValue3+((IncreaseTo));                                          % Set new minimum value


BandRed= OriginalImage(:,:,1)<= MinValue1;                                   % Select regions in the image which satisfy this condition
BandGreen= OriginalImage(:,:,2)<= MinValue2;                                 % Select regions in the image which satisfy this condition
BandBlue= OriginalImage(:,:,3)<= MinValue3;                                  % Select regions in the image which satisfy this condition

CombinedImage= BandRed|BandGreen|BandBlue;                                   % Combine the region of interest in R, G and B bands into one image. 

ImageRemoveRegions=bwareaopen(CombinedImage, NumberOfConnectedPixels);       % Remove regions whose area is below a set threshold.

ImageFilled=imclose(ImageRemoveRegions,StructuringElement);                  % Perform closing operation to fill in minor black specks within alphabets.

RemoveExtraRegions=imerode(ImageFilled,StructuringElement);                  % Perform erosion to remove unwanted extra regions.

AlphabetImage=imcomplement(RemoveExtraRegions);                              % Compliment the image to get text in white background
end