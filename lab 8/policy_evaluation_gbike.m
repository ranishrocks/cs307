function [V] = policy_evaluation_gbike(policy, Lamda, lamda, r, t, gam)

[m,n] = size(policy);

nn = 0:n-1;
P1 = exp(-Lamda(1))*(Lamda(1).^nn)./factorial(nn); 
P2 = exp(-Lamda(2))*(Lamda(2).^nn)./factorial(nn); 
P3 = exp(-lamda(1))*(lamda(1).^nn)./factorial(nn); 
P4 = exp(-lamda(2))*(lamda(2).^nn)./factorial(nn);

V=zeros(m,n);
delta=10;
theta=0.1;

while delta > theta
    v=V;
    for i=1:m
        for j=1:n
            s1=i-1; s2=j-1; % state (0-20, 0-20)
            Vs_=0; a = policy(i,j);
            
            % Adjusting for reward and transfer costs
            if a == 1
                R = -t;  % First bike shuttle is free
            elseif a > 0
                R = -abs(a) * t;  % Transfer cost for bikes moved from location 1 to location 2
            elseif a == -1
                R = -t;  % First bike shuttle is free for bikes moved from location 2 to location 1
            elseif a < 0
                R = -abs(a) * t;  % Transfer cost for bikes moved from location 2 to location 1
            else
                R = 0;  % No bike transfer
            end

            % Parking penalty if more than 10 bikes at any location
            if (s1 + a > 10)
                R = R - 4;  % Additional cost if more than 10 bikes at Location 1
            end
            if (s2 - a > 10)
                R = R - 4;  % Additional cost if more than 10 bikes at Location 2
            end

            s1_ = max(0, min(20, s1 - a)); % Ensure the state stays within bounds
            s2_ = max(0, min(20, s2 + a)); % Ensure the state stays within bounds
            for n1 = 0:12
                for n2 = 0:14
                    s1__ = s1_ - min(n1, s1_); s2__ = s2_ - min(n2, s2_);
                    for n3 = 0:12
                        for n4 = 0:9
                            s1___ = s1__ + min(n3, 20 - s1__); s2___ = s2__ + min(n4, 20 - s2__);
                            R = R + (P1(n1+1) * P2(n2+1) * P3(n3+1) * P4(n4+1) * (min(n1, s1_) + min(n2, s2_))) * r;
                            Vs_ = Vs_ + P1(n1+1) * P2(n2+1) * P3(n3+1) * P4(n4+1) * V(s1___+1, s2___+1);
                        end
                    end
                end
            end
            V(i,j) = R + gam * Vs_;
        end
    end
    delta = max(max(abs(v - V)));
end
end
