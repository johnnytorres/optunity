#! /usr/local/bin/octave-cli -q

addpath('../optunity/'); % load utilities
clear all;

function [ result ] = optunity_cv_fun( x_train, y_train, x_test, y_test, pars )
    disp('fold params:');
    disp(pars)
    disp('training set:');
    disp(x_train);
    disp(y_train);
    disp('test set:');
    disp(size(x_test));
    disp(size(y_test));

    n_tasks = length(x_train)
    result = 0

    for n=1:n_tasks
        result = result + sum(x_train{n}*pars.w + pars.b^2);
    end

    fprintf('fold result: %d \n', result);
end

%% cross-validation
%x = (1:4)'
x{1} = (1:4)';
x{2} = (5:12)';
y{1} = (1:4)'+1;
y{2} = (5:12)'+1;
%options = struct('num_folds', 5)%, 'y', [0,0,1,1,0]
cvf = cross_validate(@optunity_cv_fun, x, 'y', y, 'num_folds', 2, 'num_iter', 2);
% performance = cvf(struct('w',0.5,'b',2));

% fprintf('cv performance: %d \n', performance)
% disp(performance)

grid_solver = make_solver('grid search','w', 0.5:0.5:1, 'b', 0.5:0.5:1);
[grid_solution, grid_details] = optimize(grid_solver, cvf);

disp('done')

