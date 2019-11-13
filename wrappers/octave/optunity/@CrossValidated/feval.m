function result = feval(obj, pars)
    %Performs cross-validation as configured with hyperparameters pars and returns the
    %result.
    if ~isa(obj.fun, 'function_handle')
        error('Internal function to be cross-validated is not set.');
    end
    folds = get_folds(obj);
    performances = zeros(obj.num_folds, obj.num_iter);
    for iter = 1:obj.num_iter
        n_tasks = length(obj.x);
        for fold = 1:obj.num_folds            
            for n=1:n_tasks                
                x = obj.x{n};            
                task_fold = folds{n};
                x_train{n} = x(task_fold(:, iter) ~= fold, :);
                x_test{n} = x(task_fold(:, iter) == fold, :);
                if ~ isempty(obj.y)
                    y = obj.y{n};
                    y_train{n} = y(task_fold(:, iter) ~= fold, :);
                    y_test{n} = y(task_fold(:, iter) == fold, :);
                end
            end
            pars = setfield(pars, 'iteration', iter);
            pars = setfield(pars, 'fold', fold)
            if isempty(obj.y)
                result_per_fold = obj.fun(x_train, x_test, pars)                
            else
                result_per_fold = obj.fun(x_train, y_train, x_test, y_test, pars)
            end
            performances(fold, iter) = result_per_fold;
        end
    end
    fprintf('\n'); 
    results_per_iter = arrayfun(@(x) obj.aggregator(performances(:, x)), 1:obj.num_iter)
    result = mean(results_per_iter);
end % feval
