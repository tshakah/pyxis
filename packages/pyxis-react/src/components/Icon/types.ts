type IconSize = 's' | 'm' | 'l';

interface CommonIconProps {
  alt?: never;
  className?: string;
  description?: string;
  boxed?: boolean;
  size?: IconSize;
}

interface BoxedProps extends Omit<CommonIconProps, 'alt'> {
  alt?: boolean;
  boxed: true;
}

export type IconProps = CommonIconProps | BoxedProps;

export default {};

export type { IconSize };
