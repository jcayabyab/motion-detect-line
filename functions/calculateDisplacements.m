function [displacement] = calculateDisplacements(input)
% CALCULATEDISPLACEMENTS Input a line-time photo
% Outputs a displacement-time relationship

reference = createReference(input);
[~, grad] = imgradientxy(reference);

[~, t] = size(input);
displacement = zeros(t, 1);

i = mink(grad(:, 1), 1, 1);
a = find(grad(:, 1) == i);

for j = 1:t
    pixelDifference = double(input(a, 1)) - double(input(a, j));%from formula (top)
    s = double(pixelDifference) ./ grad(a, j); %from formula (bottom)
    displacement(j) = -s; % gradient direction is downwards
    %To make consistent with photo, flip
end

end
