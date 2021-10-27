export const capitalize = (str: string): string => {
  const splitStr = str.split('');
  splitStr.splice(0, 1, str.charAt(0).toUpperCase());
  return splitStr.join('');
};

export const kebabToPascalCase = (str: string): string => str
  .split('-')
  .map((s) => capitalize(s))
  .join('');
