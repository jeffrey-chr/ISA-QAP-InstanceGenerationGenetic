function [xout] = qapGaGenBoth(target, model, features, params, record)
%QAPGAFIXDIST Summary of this function goes here
%   Detailed explanation goes here

% Genetic representation: Parameters of flow generator
% Fitness function: Euclidean distance to target point
% Initial population: Based on closest instances to target point

    if nargin < 4
        params = struct;
    end

    % Population for genetic algorithm
    if ~isfield(params, 'gapop')
        gapop = 10;
    else
        gapop = params.gapop;
    end
        
    % Number of generations. In order to generate an interesting variety of
    % instances you might not want this to be too large. Experiment to find
    % good values for all these parameters.
    if ~isfield(params, 'gagen')
        gagen = 10;
    else
        gagen = params.gagen;
    end
    
    % Size of instances to be generated
    if ~isfield(params, 'instsize')
        n = 20;
    else
        n = params.instsize;
    end

    if ~isfield(params, 'lb')
        throw(-1);
    else
        distgen = params.distgen;
        flowgen = params.flowgen;
        lb = params.lb;
        ub = params.ub;
        intcon = params.intcon;
    end

    if ~isfield(params,'nToGen')
        otherparams.nToGen = 10;
    else
        otherparams.nToGen = params.nToGen;
    end

    if ~isfield(params,'nToPick')
        otherparams.nToPick = 5;
    else
        otherparams.nToPick = params.nToPick;
    end

    if ~isfield(params,'nToSkip')
        otherparams.nToSkip = 5;
    else
        otherparams.nToSkip = params.nToSkip;
    end
    %x0 = randi(maxvalue,gapop,2*n);
    
    %options = optimoptions('ga', 'PopulationSize', gapop, 'PlotFcn', @gaplotscores, 'MaxGenerations', gagen);
    options = optimoptions('ga', 'PopulationSize', gapop, 'MaxGenerations', gagen, 'EliteCount', 1, 'Display', 'iter');

    [xout,fval,~,output,population,scores] = ga(@(x) qapObjectiveGenBoth(x,otherparams,distgen,flowgen,target,model,features,record), length(params.lb), [], [], [], [], lb, ub, [], intcon, options);
    
    %mat1 = reshape(x(1:n^2), n, n);
    %mat2 = reshape(x((n^2+1):2*n^2), n, n);
    
    % iters = output.generations;
    % insts = population;
    % [~,tmp] = sort(scores);
    % insts = insts(tmp(1:params.instPerTarget),:);

end

