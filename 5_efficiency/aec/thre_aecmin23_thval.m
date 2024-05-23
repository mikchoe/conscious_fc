function thre_aecmin23_thval(subno,nfile,thp,lmtch)
% subno='01'; nfile='loc';
% thp: 15 20 25 30 35
% thp=20;
% lmtch = 15 20 25 (limit ch)
% lmtch =20;

%% settings
direct=['E:\#ECoGconsciousness\Connect\sub' subno];    
cd([direct '\aec\'])
load (['sub' subno '_aecminch23_' nfile '.mat'])

%%
wnetf=[]; bnetf=[]; fabth=[]; fpth=[];
lch=size(faec23,1); nconnect=lch*(lch-1)/2;

if lch < lmtch % over ch 15 or 20 or 25
    fprintf(['...low nconnect: stop thresholding....\n']);
else
    for ff=1:size(faec23,3)
        mattmp=faec23(:,:,ff); matsort=[];
        for i=1:lch   
            tmp=mattmp([i+1:lch],i);
            matsort=[matsort; tmp]; 
        end
        dmatsort = sort(matsort,'descend');
        
        thrval=thp/100; %thrval=0.15 to 0.45 (thp=15 to 45);
        nth=ceil(thrval*nconnect); abth=dmatsort(nth); pth=nth/nconnect;    

        W = threshold_absolute(mattmp, abth); W2 = weight_conversion(W, 'binarize');
        wnetf=cat(3,wnetf,W); bnetf=cat(3,bnetf,W2); fabth=[fabth; abth]; fpth=[fpth; pth];
    end
    % save file
    cd([direct '\netaec\'])
    s1=['save -v7.3 sub' subno '_thre_aecminch23_thr' num2str(thp) '_' nfile '.mat lch nconnect wnetf bnetf fabth fpth']; eval(s1);
    fprintf(['...Thresholding done....\n']);
end
fprintf(['...Thresholding aecmin23 matrix Sub' subno ' ' nfile ' finished....\n']);
end