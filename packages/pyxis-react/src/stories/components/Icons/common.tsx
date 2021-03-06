import { IconPrimaLogo } from 'components/Icon/Icons';

export const generateTestComponentMeta: GenerateAllStoriesComponentMeta<typeof IconPrimaLogo> = () => ({
  title: 'Test/Icon',
  component: IconPrimaLogo,
});

export type Size = 's' | 'm' | 'l';
export type Variant = 'neutral' | 'brand' | 'success' | 'alert' | 'error';

export interface SizeRow {
  size: Size,
  value: string
}

export const sizes: SizeRow[] = [
  {
    size: 's',
    value: '16px',
  },
  {
    size: 'm',
    value: '20px',
  },
  {
    size: 'l',
    value: '24px',
  },
];

export const variants: Variant[] = ["neutral", "brand", "success", "alert", "error"]