import Typography from './Typography';
import textSizesTokens from '@primauk/tokens/json/typography/text/sizes.json';
import textWeightsTokens from '@primauk/tokens/json/typography/text/weights.json';
import titleSizesTokens from '@primauk/tokens/json/typography/title/sizes.json';
import titleWeightsTokens from '@primauk/tokens/json/typography/title/weights.json';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Typography> = () => ({
  title: 'Test/Typography',
  component: Typography,
});

export const title: TypographyRow = {
  type: 'title',
  sizes: Object.keys(titleSizesTokens) as TitleSize[],
  weights: Object.keys(titleWeightsTokens) as TitleWeight[],
};

export const text: TypographyRow = {
  type: 'text',
  sizes: Object.keys(textSizesTokens) as TextSize[],
  weights: Object.keys(textWeightsTokens) as TextWeight[],
};

export interface TypographyRow {
  type: TypographyType
  sizes: TitleSize[] | TextSize[],
  weights: TitleWeight[] | TextWeight[];
}

export type TypographyType = 'text' | 'title';

export type TypographySize = TitleSize | TextSize;

export type TypographyWeight = TitleWeight | TextWeight;