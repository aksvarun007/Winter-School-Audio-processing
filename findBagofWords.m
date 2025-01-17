function bagOfWords = findBagofWords( clusterCentroids, X )
    
    bagOfWords = zeros( 1, size(clusterCentroids,1) );
    indices = dsearchn(clusterCentroids, X);
   
    for i = 1:size(indices),
       bagOfWords( indices(i) ) = bagOfWords( indices(i) ) + 1; 
    end
    
end