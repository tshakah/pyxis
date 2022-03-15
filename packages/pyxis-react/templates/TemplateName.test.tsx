import { render, screen } from '@testing-library/react';
import TemplateName from './TemplateName';

describe('TemplateName component', () => {
  test('it should mount', () => {
    render(<TemplateName />);

    const templateName = screen.getByTestId('TemplateName');

    expect(templateName).toBeInTheDocument();
  });
});
