String convertVolumeName(String unit) {
  switch (unit) {
    case "liters":
      return "L";
    case "grams":
      return "g";
    case "kilograms":
      return "kg";
    default:
      return unit;
  }
}
