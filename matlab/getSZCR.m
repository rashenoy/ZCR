function szcr = getszcr(x)

        %%%--------------------------------------------------------------------
        %% calculates smoothened avg group delay
        %%%--------------------------------------------------------------------
        framesize = length(x);
        
        %%%--------------------------------------------------------------------
        %% calculates SZCR
        %%--------------------------------------------------------------------
        
        %X = real(fft([zeros(framesize,1);x;zeros(8*framesize,1)]));
        %X = real(fft([x;zeros(9*framesize,1)]));
        %X = real(fft([x;zeros(3*framesize,1)]));
        X = fft([x;zeros(framesize,1)]);
        P = real(X);
        %P = P - mean(P);
        sdpind = find(P>=0);
        if(length(sdpind)==length(P))
            szcr = 0;
        else
            sdp = zeros(size(P));
            sdp(sdpind) =  ones(size(sdpind));
            dp = abs([sdp(2:length(sdp))-sdp(1:length(sdp)-1)]);
            szcr =  ((sum(dp)/(length(sdp)-1)));
        end
        %figure;plot(P);hold on;plot(0.1*sdp,'k');stem(0.1*dp,'r')
        %szcr = hekedemAR1(P, 0.1) ;
        
%         disp([num2str(szcr),'  ',num2str(alpha)]);

        Q = imag(X);
        %Q = Q - mean(Q);
        sdqind = find(Q>=0);
        if(length(sdqind) ~= length(Q))
            sdq = zeros(size(Q));
            sdq(sdqind) =  ones(size(sdqind));
            dq = abs([sdq(2:length(sdq))-sdq(1:length(sdq)-1)]);
            %disp(['P = ',int2str(sum(dq)),' Q= ',int2str(sum(dq))]);
            szcr = szcr + ((sum(dq)/(length(sdq)-1)));
        end
        szcr = framesize*szcr/2; %- 0.25;
        %disp(['P=',num2str(mean(P)),' Q=',num2str(mean(Q))]);
end        