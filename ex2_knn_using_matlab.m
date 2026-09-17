%%데이터 불러오기
clear; close all; clc;

load fisheriris;
%%각 종을 숫자로 표현 1:versicolor 2:verginica
spcs2num=[];
for k=1:1:length(species)
    if strcmp(species(k), 'versicolor')==1
        spcs2num(k,1)=1;
    elseif strcmp(species(k),'virginica')==1
        spcs2num(k,1)=2;
    end
end
%%학습데이터와 평가데이터 나누기
%오늘은 두개의 그룹만 나눠봄 versicolor vs. virginica
%편의상 아래와 같이 나눔
%1~50: setosa 51~100: versicolor 101~150: virginica
%학습데이터. 71~100: versicolor, 121~150: virginica 총 60개
%평가데이터. 51~70: versicolor, 101~120: virginica 총 40개

%일단, 사용할특징은 sepal length와 width = 1열과 2열
tr_id=[71:1:100 121:1:150];
Training_data=meas(tr_id, 1:2);
Training_label=spcs2num(tr_id,:);

ts_id=[51:1:70 101:1:120];
Test_data=meas(ts_id, 1:2);
Test_label= spcs2num(ts_id,:);

%%매트랩 내부 함수를 이용한KNN모델 만들기(학습: 결정해야할것: k, 거리를
%%어떤방법으로할지)
k=3;%인접한 이웃 3개를 봄
mdl=fitcknn(Training_data,Training_label, 'NumNeighbors',k,'Distance','euclidean');
%mdl= fitcknn(Training_data, Training_label, 'NumNeighbors', k); %knn에서
%거리를 계산하는 default방법은 유클라디안이므로 이렇게 작성해도 됨



%%평가해보기 #1
%test의 첫번쨰 데이터 넣기
result = predict(mdl, Test_data(1,:))

%%평가해보기 #2 한번에 다해보기
result=predict(mdl,Test_data)

%%그려보기
figure;
subplot(211); bar(Test_label); axis tight;
subplot(212); bar(result); axis tight;

figure;
subplot(311); bar(Test_label); axis tight;
subplot(312); bar(result); axis tight;
subplot(313); bar(Test_label-result); axis tight;

