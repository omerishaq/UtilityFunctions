function [struct_F, k] = sortParetoFrontsMinimally( Data )

    n_Datapoints = size(Data,1);
    n_Dims = size(Data,2);
    
    dummy_struct.n = 0;
    dummy_struct.S = [];
%     struct_Aux(n_Datapoints) = dummy_struct;
    for k = 1:n_Datapoints
        struct_Aux(k) = dummy_struct;
    end
    
    clear dummy_struct
    dummy_struct.F = [];
%     struct_F(n_Datapoints) = dummy_struct;
    for k = 1:n_Datapoints
        struct_F(k) = dummy_struct;
    end
    
    for i = 1:n_Datapoints
        % disp(num2str(i));
        p = Data(i,:);
        
        for j = 1:n_Datapoints
            
            if i == j
                continue
            end
            
            q = Data(j,:);
            
            if sum(p<=q) == n_Dims && sum(p<q) > 0
                struct_Aux(i).S = [struct_Aux(i).S j];
            elseif sum(q<=p) == n_Dims && sum(q<p) > 0
                struct_Aux(i).n = struct_Aux(i).n + 1;
            end
        end
        
        if struct_Aux(i).n == 0
            struct_F(1).F = [struct_F(1).F i];
        end
        
    end
    
    
    k = 1;
    while ~isempty(struct_F(k).F)

        setH = [];
        for i = 1:length(struct_F(k).F)
           p = struct_F(k).F(i);
           for j = 1:length(struct_Aux(p).S)
                q = struct_Aux(p).S(j);
                struct_Aux(q).n = struct_Aux(q).n - 1;
                if struct_Aux(q).n == 0
                    setH = [setH q];
                end
           end
        end
        k = k + 1;
        struct_F(k).F = setH;
    
    end    
    
end

