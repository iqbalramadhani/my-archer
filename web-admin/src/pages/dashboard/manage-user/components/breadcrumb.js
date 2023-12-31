import React from "react";
import styled from "styled-components";
import { Link } from "react-router-dom";
import IconChevronLeft from "components/ma/icons/mono/chevron-left";

function Breadcrumb({ children, label, to = "#" }) {
  return (
    <Container>
      <Link to={to}>
        <div className="button-back">
          <IconChevronLeft size="16" />
        </div>
      </Link>

      <div className="label">
        <span>{children || label}</span>
      </div>
    </Container>
  );
}

const Container = styled.div`
  display: flex;
  align-items: center;
  gap: 1rem;
  margin: 2rem 0;

  .button-back {
    display: flex;
    justify-content: center;
    align-items: center;

    width: 1.5rem;
    height: 1.5rem;
    border-radius: 50%;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.15);
    background-color: #ffffff;

    color: var(--ma-blue);
    font-size: 1rem;
    font-weight: 600;
  }

  .label {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 1rem;
    font-weight: 600;
    color: var(--ma-gray-600);
  }
`;

export { Breadcrumb };
