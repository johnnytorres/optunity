function folds = get_folds(obj)
    %Returns the folds to be used in cross-validation.
    % The result is a matrix of size num_instances * num_iter.
    %disp(size(obj.x, 1));
    if obj.regenerate_folds || isempty(obj.current_folds)
        n_tasks = length(obj.x);
        for n=1:n_tasks  
            fprintf('generating fold for task: %d \r', n);          
            obj.current_folds{n} = generate_folds(size(obj.x{n}, 1), 'num_folds', obj.num_folds, ...
                'num_iter', obj.num_iter, 'strata', obj.strata, 'clusters', obj.clusters);
        end
    end
    folds = obj.current_folds;
end % get_folds
