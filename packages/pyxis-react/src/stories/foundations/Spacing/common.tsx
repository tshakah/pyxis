import { Spacing as SpacingShape } from './Spacing';
import spacingTokens from '@pyxis/tokens/json/spacings.json';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof SpacingShape> = () => ({
  title: 'Test/Spacing',
  component: SpacingShape,
});

export const spacings:SpacingRow[] = Object.entries(spacingTokens).flatMap(([size, values]) => ({
  size: size as Spacing,
  baseValue: values.base,
  maxValue: Math.max(...Object.values(values))
}));

export interface SpacingRow {
  size: Spacing;
  baseValue: number;
  maxValue: number;
}