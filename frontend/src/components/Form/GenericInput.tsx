import {
    Box,
    FormLabel,
    Input,
    InputGroup,
    InputLeftElement,
    InputRightElement,
} from '@chakra-ui/react';
import { ReactNode } from 'react';
import { Control, Controller } from 'react-hook-form';

interface GenericInputProps {
    name: string;
    placeholder: string;
    label: string;
    control: Control<any, any>;
    type?: 'text' | 'number' | 'email' | 'password';
    rules?: Record<string, any>;
    rightAdornment?: ReactNode;
    leftAdornment?: ReactNode;
}

function GenericInput({
    placeholder,
    label,
    name,
    control,
    type,
    leftAdornment,
    rightAdornment,
    rules = {},
}: GenericInputProps) {
    return (
        <Controller
            control={control}
            name={name}
            rules={rules}
            render={({ field, fieldState }) => (
                <Box>
                    <FormLabel>
                        {label}
                        {rules.required && (
                            <span style={{ color: 'red' }}>*</span>
                        )}
                    </FormLabel>
                    <InputGroup>
                        {rightAdornment && (
                            <InputRightElement
                                pointerEvents="none"
                                children={rightAdornment}
                            />
                        )}
                        <Input
                            {...field}
                            placeholder={
                                fieldState.error?.message ?? placeholder
                            }
                            type={type}
                            isInvalid={!!fieldState.error}
                            errorBorderColor="crimson"
                        />
                        {leftAdornment && (
                            <InputLeftElement
                                pointerEvents="none"
                                children={leftAdornment}
                            />
                        )}
                    </InputGroup>
                </Box>
            )}
        />
    );
}

export default GenericInput;
