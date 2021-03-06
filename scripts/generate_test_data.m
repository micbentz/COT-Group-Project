function [ X, Y ] = generate_test_data( filename, percent )
%GENERATE_TEST_DATA

Data = dlmread(filename);

[m n] = size(Data);

%Make sure data is sorted by class
Data = sortrows(Data);

%Generate test and training dataset
Test = [];
Train = [];
i = 0;
while(i < m)
    first = i + 1;
    len = size(find(Data(:,1) == Data(first,1)),1);
    i = i + len;
    last = i;
    
    [trainInd,valInd,testInd] = dividerand(len, 1 - percent, 0, percent);
    
    Train = [Train; removerows(Data(first:last,:), testInd)];
    Test = [Test; removerows(Data(first:last,:), trainInd)];
end

%trainPer = num2str((1 - percent)*100);
testPer = num2str(percent*100);

%Output files
dlmwrite(strcat('../datasets/', filename, '.', testPer,  '.train'), Train, ' ');
dlmwrite(strcat('../datasets/', filename, '.', testPer, '.test'), Test, ' ');

%Return training and testing datasets
X = Train;
Y = Test;

end

