export const capitalize = (str: string): string => {
  const splitStr = str.split('');
  splitStr.splice(0, 1, str.charAt(0).toUpperCase());
  return splitStr.join('');
};

export const kebabToPascalCase = (str: string): string => str
  .split('-')
  .map((s) => capitalize(s))
  .join('');

export const kebabToCamelCase = (str: string): string => str
  .split('-')
  .map((s, index) => (index !== 0 ? capitalize(s) : s))
  .join('');

export const pascalToKebab = (str: string): string => str
  .replace(/([a-z])([A-Z]|[\d])/g, '$1-$2')
  .replace(/\s+/g, '-')
  .toLowerCase();

export const kebabToStartCase = (str: string): string => str
  .split('-')
  .map((s) => capitalize(s))
  .join(' ');

export function repeat<T>(element: T, times: number): T[] {
  const array = (new Array(times));
  array.fill(element);

  return array;
}
