const double concentricRatio = 0.83333333333;
const double logoRatio = 0.438;

double innerRadius(double outerRadius) =>
    ((outerRadius * 2) * concentricRatio) / 2;

double logoHeight(double outerRadius) => ((outerRadius * 2) * logoRatio);
