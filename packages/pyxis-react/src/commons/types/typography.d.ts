import textSizesTokens from '@primauk/tokens/json/typography/text/sizes.json';
import textWeightsTokens from '@primauk/tokens/json/typography/text/weights.json';
import titleSizesTokens from '@primauk/tokens/json/typography/title/sizes.json';
import titleWeightsTokens from '@primauk/tokens/json/typography/title/weights.json';

declare global {
  type TitleSize = keyof (typeof titleSizesTokens);
  type TitleWeight = keyof (typeof titleWeightsTokens);
  type TextSize = keyof (typeof textSizesTokens);
  type TextWeight = keyof (typeof textWeightsTokens);
}
