
datacontent = readtable('data.csv');
X = datacontent{:,8:13};

[m, n] = size(X);
mu = mean(X, 1); 
Y = X - repmat(mu, m, 1);
covvx = Y'*Y/(m - 1);       
[V, S] = eig_decomp(covvx);
V1 = V(:,1:2);               % only top 2 are considered for eigen vectors
Z = Y * V1;    

%categorizing food groups 
FoodGroups = categorical(datacontent.FoodGroup);
meats = Z(any(FoodGroups == {'Beef Products', 'Lamb, Veal, and Game Products', 'Pork Products', 'Poultry Products', 'Sausages and Luncheon Meats'},2), :);
fish = Z(FoodGroups == 'Finfish and Shellfish Products', :);
sweets = Z(FoodGroups == 'Sweets', :);
fruit = Z(FoodGroups == 'Fruits and Fruit Juices', :);
beans = Z(FoodGroups == 'Legumes and Legume Products', :);
veg = Z(FoodGroups == 'Vegetables and Vegetable Products', :);
grains = Z(any(FoodGroups == {'Baked Products', 'Breakfast Cereals', 'Cereal Grains and Pasta'},2), :);



%plotting
figure
hold on
scatter(meats(:,1), meats(:,2), '.')
scatter(fish(:,1), fish(:,2), '.')
scatter(sweets(:,1), sweets(:,2), '.')
scatter(fruit(:,1), fruit(:,2), '.')
scatter(beans(:,1), beans(:,2), '.')
scatter(veg(:,1), veg(:,2), '.')
scatter(grains(:,1), grains(:,2), '.')
hold off
legend({'Meats', 'Fish', 'Sweets', 'Fruits', 'Beans', ...
    'Vegetables', 'Grains'}, 'Location', 'northeast');
title('Nutritional Classification of Food Groups');
xlabel('First Principal Component');
ylabel('Second Principal Component');

%function for eigen value decomposition 
function [eigvec_St1,eigval_St1]=eig_decomp(St1)
    [eigvec,eigval]=eig(St1);
    eigval=abs(diag(eigval)');		
    [eigval,I]=sort(eigval);
    eigval_St1=diag(fliplr(eigval)); 
    eigvec_St1=fliplr(eigvec(:,I));
end

