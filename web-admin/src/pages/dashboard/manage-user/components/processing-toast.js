import * as React from "react";
import toast, { Toaster } from "react-hot-toast";

function ProcessingToast() {
  React.useEffect(() => {
    toast.dismiss();
  }, []);

  return (
    <Toaster
      containerStyle={{ top: 80 }}
      toastOptions={{
        success: {
          style: { background: "var(--ma-primary-blue-50)" },
        },
      }}
    />
  );
}

export { toast, ProcessingToast };
