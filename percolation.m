percImage = rand(5e2,5e2);

f = figure('color','w');
for tt = 0.1:0.025:0.9
    BW = (percImage > tt);

    CC = bwconncomp(BW);
    L = labelmatrix(CC);
    RGB = label2rgb(L,'jet','k','shuffle');

    subplot(2,3,3)
    imshow(BW);
    subplot(2,3,[1,2,4,5])
    imshow(RGB)
    title(sprintf('Punched, p: %.2f%%',tt));
    axis('square')

    subplot(2,3,6)
    SS = regionprops(CC,'Area');
    clusterAreas = [SS.Area];
    numBins = max(min(50,length(unique(clusterAreas))),2);
    [binCenters,N,Nnorm] = binLogLog(numBins,clusterAreas);
    loglog(binCenters,N,'o-k')
    axis('square')
    xlim([0.1,2.5e5])
    xlabel('Cluster area')
    ylabel('Frequency')
    title(sprintf('Cluster sizes %u-%u',min(clusterAreas),max(clusterAreas)))

    s = input('Type ''q'' to quit','s');
    if strcmp(s,'q')
        break
    end
end
