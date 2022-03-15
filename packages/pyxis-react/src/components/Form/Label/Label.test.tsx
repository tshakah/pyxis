import { render, screen } from '@testing-library/react';
import Label from './Label';

describe('Label component', () => {
  describe('with default options', () => {
    test('should render with textual content', () => {
      render(<Label id="default">Label</Label>);
      const label = screen.getByTestId('default');
      expect(label).toBeInTheDocument();
      expect(label).toHaveTextContent('Label');
      expect(label).toHaveClass('form-label');
    });
  });

  describe('has a subText', () => {
    test('should render the text', () => {
      render(<Label id="sub-text" subText="Sub Label">Label</Label>);
      const subText = screen.getByTestId('sub-text');
      const subElement = subText.querySelector('small');
      expect(subElement).toBeInTheDocument();
      expect(subElement).toHaveTextContent('Sub Label');
      expect(subElement).toHaveClass('form-label__sub');
    });
  });

  describe('has a size', () => {
    test('should be small', () => {
      render(<Label id="size-small" size="small">Label</Label>);
      expect(screen.getByTestId('size-small')).toHaveClass('form-label form-label--small');
    });
  });

  describe('generic options', () => {
    test('should have a htmlFor', () => {
      render(<Label htmlFor="input-id" id="html-for">Label</Label>);
      expect(screen.getByTestId('html-for')).toHaveAttribute('for', 'input-id');
    });

    test('should have a custom class', () => {
      render(<Label className="custom-class-name" id="custom-class">Label</Label>);
      expect(screen.getByTestId('custom-class')).toHaveClass('form-label custom-class-name');
    });
  });
});
