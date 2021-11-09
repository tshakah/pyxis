import { FC } from 'react';
import './Radius.scss';

const Radius: FC<RadiusProps> = ({ size }) => (
  <div className={`radius radius-${size}`}>
    {`radius-${size}`}
  </div>
);

export default Radius;

interface RadiusProps {
  size: RadiusSize
}

export type RadiusSize = 'xl' | 'l' | 'm' | 's' | 'xs';
