import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom/extend-expect';
import { IconCar } from 'components/Icon/Icons';
import Addon, { getAddonStringType } from './Addon';

describe('Addon component', () => {
  test('it should mount', () => {
    render(<Addon addon="text-addon" id="id-addon" />);
    const addon = screen.getByTestId('id-addon');
    expect(addon).toBeInTheDocument();
    expect(addon).toHaveClass('form-field__addon');
    expect(addon).toHaveAttribute('id', 'id-addon');
  });

  test('it renders a text addon', () => {
    const content = 'text-addon';
    render(<Addon addon={content} id="id-addon" />);
    const addon = screen.getByTestId('id-addon');
    expect(addon).toHaveTextContent(content);
  });

  test('it renders an icon', () => {
    render(<Addon addon={IconCar} id="id-addon" />);
    const addon = screen.getByTestId('id-addon');
    const icon = addon.querySelector('svg');
    expect(icon).toBeInTheDocument();
  });

  describe('`getAddonStringType` function', () => {
    test('it should return `text` if addon type is `string`', () => {
      const addonType = getAddonStringType('string addon');
      expect(addonType).toBe('text');
    });
    test('it should return `icon` if addon type an icon element', () => {
      const addonType = getAddonStringType(IconCar);
      expect(addonType).toBe('icon');
    });
  });
});
