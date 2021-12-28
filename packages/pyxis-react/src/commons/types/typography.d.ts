import textSizesTokens from '@pyxis/tokens/json/typography/text/sizes.json';
import textWeightsTokens from '@pyxis/tokens/json/typography/text/weights.json';
import titleSizesTokens from '@pyxis/tokens/json/typography/title/sizes.json';
import titleWeightsTokens from '@pyxis/tokens/json/typography/title/weights.json';

declare global {
  type TitleSize = keyof (typeof titleSizesTokens);
  type TitleWeight = keyof (typeof titleWeightsTokens);
  type TextSize = keyof (typeof textSizesTokens);
  type TextWeight = keyof (typeof textWeightsTokens);
}
