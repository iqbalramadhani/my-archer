import * as React from "react";

function IconBow({ size = 24 }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M5.99998 18L21.5 2.5M20.425 21.96L19.638 21.803C18.463 21.568 17.928 19.9995 18.3015 18.861C19.2785 15.881 18.5625 12.056 18.1665 10.4045C18.0435 9.8925 17.6375 9.5075 17.1265 9.3795L15.995 9.097C15.7312 9.03107 15.4903 8.89468 15.298 8.70243C15.1058 8.51017 14.9694 8.26928 14.9035 8.0055L14.621 6.8745C14.493 6.363 14.1085 5.9575 13.596 5.8345C11.945 5.4385 8.11898 4.722 5.13948 5.6995C4.00148 6.073 2.43298 5.5375 2.19798 4.3625L2.03998 3.5755L20.425 21.96ZM2.99998 5.5L19 21.5L2.99998 5.5Z"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

export default IconBow;
