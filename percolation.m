percImage = rand(5e2,5e2);

f = figure('color','w');
for tt = 0.1:0.05:0.9
    BW = (percImage > tt);

    CC = bwconncomp(BW);
    L = labelmatrix(CC);
    RGB = label2rgb(L,'turbo','k','shuffle');

    subplot(131)
    imshow(BW);
    subplot(132)
    imshow(RGB)
    title(sprintf('Punched, p: %.2f%%',tt));
    axis('square')

    subplot(133)
    SS = regionprops(CC,'Area');
    clusterAreas = [SS.Area];
    numBins = max(min(50,length(unique(clusterAreas))),2);
    [binCenters,N,Nnorm] = binLogLog(numBins,clusterAreas);
    loglog(binCenters,N,'o-k')
    axis('square')
    xlabel('Cluster area')
    ylabel('Probability')
    title(sprintf('Cluster sizes %u-%u',min(clusterAreas),max(clusterAreas)))

    s = input('Type ''q'' to quit','s');
    if strcmp(s,'q')
        break
    end
end
