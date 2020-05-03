function folds = get_folds(obj)
    %Returns the folds to be used in cross-validation.
    % The result is a matrix of size num_instances * num_iter.
    %disp(size(obj.x, 1));
    if obj.regenerate_folds || isempty(obj.current_folds)
        n_tasks = length(obj.x);
        for n=1:n_tasks  
            num_instances = size(obj.x{n}, 1);
            %fprintf('generating folds for task: %d \r', n);          
            % obj.current_folds{n} = generate_folds(num_instances, 'num_folds', obj.num_folds, ...
            %     'num_iter', obj.num_iter, 'strata', obj.strata, 'clusters', obj.clusters);
            % a simple Kfold method to avoid issue with sockets creations ...
            %   error: bind failed with error 48 (Address already in use)
            obj.current_folds{n} = datasplitind( num_instances, obj.num_folds, true);
        end
        fprintf('\n');          
    end
    folds = obj.current_folds;
end % get_folds
