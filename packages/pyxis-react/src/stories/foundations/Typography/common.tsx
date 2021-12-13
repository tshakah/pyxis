import Typography, { Size, Type, Weight } from './Typography';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof Typography> = () => ({
  title: 'Test/Typography',
  component: Typography,
});

export interface TypographyRow {
  type: Type
  sizes: Size[],
  weights: Weight[];
}

// TODO: to be replaced with design tokens
export const title: TypographyRow = {
  type: 'title',
  sizes: ['xl', 'l', 'm', 's'],
  weights: ['bold', 'book'],
};

// TODO: to be replaced with design tokens
export const text: TypographyRow = {
  type: 'text',
  sizes: ['l', 'm', 's'],
  weights: ['bold', 'book', 'light'],
};
